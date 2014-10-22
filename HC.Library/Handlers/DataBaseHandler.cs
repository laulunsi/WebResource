using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using System.Web;
using System.Xml;
using HC.Framework.DataBase;
using HC.Framework.DataBase.DBManager;
using HC.Framework.Helper;

namespace HC.Ajax.Handlers
{
    /// <summary>
    ///     数据库管理类
    /// </summary>
    public class DataBaseHandler : AjaxHandler
    {
        /// <summary>
        ///     查询数据
        /// </summary>
        /// <param name="xmldoc"></param>
        /// <returns></returns>
        public static Dictionary<string, string> GetData(XmlDocument xmldoc)
        {
            var resultDic = new Dictionary<string, string>();
            string sql = HttpUtility.UrlDecode(GetNodeInnerText(xmldoc, "sql"));
            int dbId = Convert.ToInt32(HttpUtility.UrlDecode(GetNodeInnerText(xmldoc, "dbId")));

            string result;
            string status = "false";

            #region 检查数据库连接

            var con = new DbConnection();
            string configText = ConfigHelper.ReadConfig<DbConnection>();
            if (!string.IsNullOrEmpty(configText))
            {
                var dbs = (List<DbConnection>) ConfigHelper.Deserialize(typeof (List<DbConnection>), configText);
                foreach (DbConnection connection in dbs)
                {
                    if (dbId == connection.Id)
                    {
                        con = new DbConnection
                            {
                                Server = connection.Server,
                                DataBase = connection.DataBase,
                                UserName = connection.UserName,
                                Password = connection.Password,
                                Id = connection.Id
                            };
                        break;
                    }
                }
            }

            #endregion

            if (con.Id > 0)
            {
                bool haveForbidWord = DBManager.IsContainDangerWords(sql);
                if (haveForbidWord)
                {
                    var builder = new StringBuilder();
                    foreach (string forbidWord in DBManager.ForbidSqlKeyword)
                    {
                        builder.Append(forbidWord + ",");
                    }
                    result = ("数据脚本不符合规定,脚本：" + sql + "，含有数据库非数据库查询关键字,如：" + builder.ToString().TrimEnd(','));
                }
                else
                {
                    result = DBManager.SelectData(sql, con.GetConnection());
                    status = "true";
                }
            }
            else
            {
                result = "数据库连接不存在";
            }

            resultDic.Add("result", result);
            resultDic.Add("status", status);
            return resultDic;
        }

        /// <summary>
        ///     翻译
        /// </summary>
        /// <param name="xmldoc"></param>
        /// <returns></returns>
        public static Dictionary<string, string> Translater(XmlDocument xmldoc)
        {
            var resultDic = new Dictionary<string, string>();
            string status = "false";
            string result = "未知异常";
            try
            {
                string input = HttpUtility.UrlDecode(GetNodeInnerText(xmldoc, "input"));
                string form = HttpUtility.UrlDecode(GetNodeInnerText(xmldoc, "form"));
                string type = HttpUtility.UrlDecode(GetNodeInnerText(xmldoc, "type"));
                if (!string.IsNullOrEmpty(input))
                {
                    string fromType = String.Compare(form, "en", StringComparison.OrdinalIgnoreCase) == 0
                                          ? LanguageType.English
                                          : LanguageType.Chinese;
                    string toType = fromType == LanguageType.English ? LanguageType.Chinese : LanguageType.English;
                    string tranType = String.Compare(type, "google", StringComparison.OrdinalIgnoreCase) == 0
                                          ? TranslationType.Google
                                          : TranslationType.Bing;
                    result = UpperFistCharAndTrim(TranslaterHelper.Translate(input, fromType, toType, tranType).Trim());
                    status = "true";
                }
            }
            catch (Exception ex)
            {
                result = "异常：" + ex.Message;
            }
            resultDic.Add("result", result);
            resultDic.Add("status", status);
            return resultDic;
        }

        /// <summary>
        ///     首字母大写并移除空格
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public static string UpperFistCharAndTrim(string input)
        {
            if (!string.IsNullOrEmpty(input))
            {
                string result = string.Empty;
                string[] words = input.Split(new[] {" "}, StringSplitOptions.RemoveEmptyEntries);
                for (int index = 0; index < words.Length; index++)
                {
                    string word = words[index].Trim();
                    word = word.ToCharArray()[0].ToString(CultureInfo.InvariantCulture).ToUpper() + word.Substring(1);
                    result += word;
                }
                return result;
            }
            return string.Empty;
        }

        /// <summary>
        ///     测试数据库链接
        /// </summary>
        /// <param name="xmldoc"></param>
        /// <returns></returns>
        public static Dictionary<string, string> DbTest(XmlDocument xmldoc)
        {
            var resultDic = new Dictionary<string, string>();
            string status = "err";
            string result;
            try
            {
                string serverAddress = HttpUtility.UrlDecode(GetNodeInnerText(xmldoc, "server"));
                string dataBaseName = HttpUtility.UrlDecode(GetNodeInnerText(xmldoc, "database"));
                string userName = HttpUtility.UrlDecode(GetNodeInnerText(xmldoc, "userName"));
                string pwd = HttpUtility.UrlDecode(GetNodeInnerText(xmldoc, "pwd"));
                string con = string.Format("server={0};database={1};uid={2};pwd={3}", serverAddress,
                                           dataBaseName, userName, pwd);
                ConnectionStatus conStatus = DBManager.CheckConnection(con);
                if (conStatus.IsSucess)
                {
                    result = "连接成功！";
                    status = "ok";
                }
                else
                {
                    result = "连接失败:" + conStatus.Message;
                }
            }
            catch (Exception ex)
            {
                result = "异常：" + ex.Message;
            }
            resultDic.Add("result", result);
            resultDic.Add("status", status);
            return resultDic;
        }
    }
}