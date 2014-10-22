using System.Collections.Generic;
using System.Web;
using System.Xml;
using HC.Framework.Helper;

namespace HC.Ajax.Handlers
{
    /// <summary>
    ///     数据格式化器
    /// </summary>
    public class DataFormatHandler : AjaxHandler
    {
        /// <summary>
        ///     格式化Html
        /// </summary>
        /// <param name="xmldoc"></param>
        /// <returns></returns>
        public static Dictionary<string, string> HtmlFormat(XmlDocument xmldoc)
        {
            var resultDic = new Dictionary<string, string>();
            string input = HttpUtility.UrlDecode(GetNodeInnerText(xmldoc, "input"));
            string result = HtmlFormater.FormatHtml(input, true);
            string status = result.StartsWith("异常") ? "err" : "ok";
            resultDic.Add("result", result);
            resultDic.Add("status", status);
            return resultDic;
        }

        /// <summary>
        ///     格式化Xml
        /// </summary>
        /// <param name="xmldoc"></param>
        /// <returns></returns>
        public static Dictionary<string, string> XmlFormat(XmlDocument xmldoc)
        {
            var resultDic = new Dictionary<string, string>();
            string input = HttpUtility.UrlDecode(GetNodeInnerText(xmldoc, "input"));
            string result = XmlFormater.FormatXml(input);
            string status = result.StartsWith("异常") ? "err" : "ok";
            resultDic.Add("result", result);
            resultDic.Add("status", status);
            return resultDic;
        }
    }
}