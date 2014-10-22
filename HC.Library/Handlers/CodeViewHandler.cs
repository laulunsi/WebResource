using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Web;
using System.Xml;
using HC.Ajax.Extension;
using HC.Framework.Extension;
using HC.Service.CodeView;

namespace HC.Ajax.Handlers
{
    public class CodeViewHandler : AjaxHandler
    {
        /// <summary>
        ///     查询数据
        /// </summary>
        /// <param name="xmldoc"></param>
        /// <returns></returns>
        public static Dictionary<string, string> GetData(XmlDocument xmldoc)
        {
            var resultDic = new Dictionary<string, string>();
            string q = HttpUtility.UrlDecode(GetNodeInnerText(xmldoc, "q"));
            int pageIndex = GetNodeInnerText(xmldoc, "pageIndex").ToInt(1);
            int pageSize = GetNodeInnerText(xmldoc, "pageSize").ToInt();

            Stopwatch sw = new Stopwatch();
            sw.Start();
 
            int count;
            var search = CodeViewService.DoSearch(q, (pageIndex - 1) * pageSize, pageSize, out count);

            string result;
            string status = "false";
            try
            {
                result = search.ToJson();
                status = "true";
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            sw.Stop();
            TimeSpan ts = sw.Elapsed;
            string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}", ts.Hours, ts.Minutes, ts.Seconds, ts.Milliseconds / 10);
            resultDic.Add("body", result);
            resultDic.Add("total", count.ToStr());
            resultDic.Add("result", result);
            resultDic.Add("status", status);
            resultDic.Add("time", elapsedTime);
            
            return resultDic;
        }
        /// <summary>
        ///     生成索引
        /// </summary>
        /// <param name="xmldoc"></param>
        /// <returns></returns>
        public static Dictionary<string, string> CreateLuceneNetIndex(XmlDocument xmldoc)
        {
            var resultDic = new Dictionary<string, string>();

            string result;
            string status = "false";
            try
            {
                CodeViewService.CreateSearchIndex();
                result = "索引生成成功！";
                status = "true";
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            resultDic.Add("body", result);
            resultDic.Add("result", result);
            resultDic.Add("status", status);
            return resultDic;
        }
    }
}