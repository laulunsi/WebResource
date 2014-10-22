using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Xml;
using HC.Ajax.Extension;
using HC.Framework.Helper;

namespace HC.Ajax.Handlers
{
    public class NavigateHandler : AjaxHandler
    {
        public static Dictionary<string, string> GetNavHtml(XmlDocument xmldoc)
        {
            var resultDic = new Dictionary<string, string>();

            string result = "";
            string status = "false";

            string config = HttpContext.Current.Server.MapPath("~/config/Navigation.config"); //ToDo：缓存
            string xml = FileHelper.ReadFile(config);
            var doc = new XmlDocument();
            doc.LoadXml(xml);
            XmlNodeList menus = doc.SelectNodes("root/menu");
            var dt = new DataTable();
            dt.Columns.Add("name");
            dt.Columns.Add("url");
            if (menus != null)
            {
                foreach (XmlNode menu in menus)
                {
                    DataRow row = dt.NewRow();
                    if (menu.Attributes != null)
                    {
                        row["name"] = menu.Attributes["name"];
                        row["url"] = menu.Attributes["url"];
                    }
                    dt.Rows.Add(row);
                }
                result = dt.ToJson();
                status = "true";
            }

            resultDic.Add("result", result);
            resultDic.Add("status", status);
            return resultDic;
        }
    }
}