using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Xml;
using HC.Framework.Extension;
using HC.Framework.Helper;

namespace HC.Foundation.Page
{
    public class BasePage : System.Web.UI.Page
    {
        /// <summary>
        /// 网站根目录路径，末尾已包含“/”
        /// </summary>
        public string BasePath
        {
            get { return VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath); }
        }

        #region Url查询参数
        /// <summary>
        /// 获取指定查询字符串变量的 Int32 值，如果获取失败则返回默认值。
        /// </summary>
        /// <param name="queryItem"></param>
        /// <returns></returns>
        public static int RequestInt32(string queryItem)
        {
            return RequestInt32(queryItem, 0);
        }

        /// <summary>
        /// 获取指定查询字符串变量的 Int32 值，如果获取失败则返回默认值。
        /// </summary>
        /// <param name="queryItem">查询字符串变量</param>
        /// <param name="defaultValue">默认值</param>
        /// <returns>查询参数值</returns>
        public static int RequestInt32(string queryItem, int defaultValue)
        {
            return HttpContext.Current.Request.QueryString[queryItem].ToInt(defaultValue);
        }
        /// <summary>
        ///获取指定查询字符串变量的 String 值，如果获取失败则返回默认字符串。
        /// </summary>
        /// <param name="queryItem"></param>
        /// <returns></returns>
        public static string RequestString(string queryItem)
        {
            return RequestString(queryItem, string.Empty);
        }

        /// <summary>
        /// 获取指定查询字符串变量的 String 值，如果获取失败则返回默认字符串。
        /// </summary>
        /// <param name="queryItem">查询字符串变量</param>
        /// <param name="defaultValue">默认值</param>
        /// <returns>查询参数值</returns>
        public static string RequestString(string queryItem, string defaultValue)
        {
            string requestString = HttpContext.Current.Request.QueryString[queryItem];
            if (requestString == null)
            {
                return defaultValue;
            }
            return requestString.Trim();
        }
        #endregion

    }
}