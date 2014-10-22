using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Web;
using HC.Framework.Helper;
using HC.Model.CodeView;
using Lucene.Net.Analysis;
using Lucene.Net.Analysis.PanGu;
using Lucene.Net.Documents;
using Lucene.Net.Index;
using Lucene.Net.Search;
using Lucene.Net.Store;
using PanGu;
using PanGu.HighLight;

namespace HC.Service.CodeView
{
    public class CodeViewService
    {
        /// <summary>
        ///     全文搜索文件路径
        /// </summary>
        private static string _indexPath = HttpContext.Current.Server.MapPath("~/CodeView/LuceneNetIndex");
        static readonly string CodePath = HttpContext.Current.Server.MapPath("~/CodeView/Source");

        #region 创建全文索引

        /// <summary>
        ///     创建全文索引
        /// </summary> 
        public static void CreateSearchIndex()
        {
            //索引库的位置
            _indexPath = HttpContext.Current.Server.MapPath("~/CodeView/LuceneNetIndex");
            FSDirectory directory = FSDirectory.Open(new DirectoryInfo(_indexPath), new NativeFSLockFactory());
            bool isUpdate = IndexReader.IndexExists(directory);
            if (isUpdate)
            {
                if (IndexWriter.IsLocked(directory))
                {
                    IndexWriter.Unlock(directory);
                }
            }
            var write = new IndexWriter(directory, new PanGuAnalyzer(), !isUpdate, IndexWriter.MaxFieldLength.UNLIMITED);

            var list = new List<string>();
            FileHelper.GetFiles(CodePath, list);

            for (int i = 0; i < list.Count; i++)
            {
                var file = new FileInfo(list[i]);
                string title = file.Name;
                string body = FileHelper.ReadFile(file.FullName);
                write.DeleteDocuments(new Term("number", i.ToString(CultureInfo.InvariantCulture)));

                var document = new Document();
                document.Add(new Field("number", i.ToString(CultureInfo.InvariantCulture), Field.Store.YES,Field.Index.NOT_ANALYZED));
                document.Add(new Field("title", title, Field.Store.YES, Field.Index.NOT_ANALYZED));
                document.Add(new Field("fullPath", file.FullName.Replace(CodePath, ""), Field.Store.YES, Field.Index.NOT_ANALYZED));
                document.Add(new Field("body", body, Field.Store.YES, Field.Index.ANALYZED, Field.TermVector.WITH_POSITIONS_OFFSETS));
                write.AddDocument(document);
            }
            write.Optimize();//优化索引
            write.Close();
            directory.Close();
        }

        #endregion

        #region 全文搜索

        /// <summary>
        ///     全文搜索
        /// </summary>
        /// <param name="keyword"></param>
        /// <param name="startRowIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="totalCount"></param>
        /// <returns></returns>
        public static List<SearchResult> DoSearch(string keyword, int startRowIndex, int pageSize, out int totalCount)
        {
            FSDirectory directory = FSDirectory.Open(new DirectoryInfo(_indexPath), new NoLockFactory());
            IndexReader reader = IndexReader.Open(directory, true);
            //IndexSearcher是进行搜索的类
            var searcher = new IndexSearcher(reader);
            var query = new PhraseQuery();

            foreach (string word in GetKeyWords(keyword))
            {
                query.Add(new Term("body", word));
            }
            query.SetSlop(100); //相聚100以内才算是查询到
            TopScoreDocCollector collector = TopScoreDocCollector.create(1024, true); //最大1024条记录
            searcher.Search(query, null, collector);
            totalCount = collector.GetTotalHits(); //返回总条数
            ScoreDoc[] docs = collector.TopDocs(startRowIndex, pageSize).scoreDocs; //分页,下标应该从0开始吧，0是第一条记录
            var list = new List<SearchResult>();

            for (int i = 0; i < docs.Length; i++)
            {
                int docId = docs[i].doc; //取文档的编号，这个是主键，lucene.net分配
                //检索结果中只有文档的id，如果要取Document，则需要Doc再去取
                //降低内容占用
                Document doc = searcher.Doc(docId);
                string number = doc.Get("number");
                string title = doc.Get("title");
                string fullPath = doc.Get("fullPath");
                string body = doc.Get("body");

                var searchResult = new SearchResult
                    {
                        Number = number,
                        Title = title,
                        FullPath = fullPath,
                        BodyPreview = Preview(body, keyword)
                    };
                list.Add(searchResult);
            }
            return list;
        }

        private static string Preview(string body, string keyword)
        {
            var formatter = new SimpleHTMLFormatter("<font color=\"Red\">", "</font>");
            var highlighter = new Highlighter(formatter, new Segment());
            highlighter.FragmentSize = 120;
            string fragment = highlighter.GetBestFragment(keyword, body);
            return fragment;
        }

        public static string[] GetKeyWords(string str)
        {
            var list = new List<string>();
            Analyzer analyzer = new PanGuAnalyzer();
            TokenStream tokenStream = analyzer.TokenStream("", new StringReader(str));
            Token token;
            while ((token = tokenStream.Next()) != null)
            {
                list.Add(token.TermText());
            }
            return list.ToArray();
        }

        #endregion
    }
}