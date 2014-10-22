using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Xml;
using HC.Framework.Helper;

namespace HC.Foundation.Page
{
    public class AdminPage : BasePage
    {
        /// <summary>
        /// 网站管理根目录路径，末尾已包含“/”
        /// </summary>
        public string AdminPath
        {
            get { return VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "Admin/"; }
        }

        /// <summary>
        ///     引发 Init 事件以对页进行初始化
        /// </summary>
        /// <param name="e">事件数据</param>
        protected override void OnInit(EventArgs e)
        {
            //if (HttpContext.Current.User.Identity.IsAuthenticated)
            //{

            base.OnInit(e);

            #region 设置站点标题

            Page.Header.Title = string.IsNullOrEmpty(Page.Header.Title)
                                    ? "HelloCode"
                                    : Page.Header.Title + "-" + "HelloCode";

            #endregion

            string config = FileHelper.ReadFile(Server.MapPath("~/Config/ResourceReference.config"));
            var doc = new XmlDocument();
            doc.LoadXml(config);
            XmlNodeList css = doc.SelectNodes("root/css/file");
            XmlNodeList javascript = doc.SelectNodes("root/javascript/file");

            Page.Header.Controls.Add(
                new LiteralControl(Environment.NewLine + "<link rel='shortcut icon' href='/favicon.ico' />" +
                                   Environment.NewLine));

            #region 引入css

            Page.Header.Controls.Add(new LiteralControl(Environment.NewLine + "<!--引用css-->" + Environment.NewLine));
            if (css != null)
            {
                foreach (XmlNode node in css)
                {
                    string path = node.InnerText;
                    var control = new HtmlGenericControl("link");
                    control.Attributes["type"] = "text/css";
                    control.Attributes["rel"] = "stylesheet";
                    control.Attributes["media"] = "all";
                    control.Attributes["href"] = ResolveUrl(path);
                    Page.Header.Controls.Add(control);
                    Page.Header.Controls.Add(new LiteralControl(Environment.NewLine));
                }
            }

            #endregion

            #region 引入js库

            Page.Header.Controls.Add(new LiteralControl("<!--引用js-->" + Environment.NewLine));
            if (javascript != null)
            {
                foreach (XmlNode node in javascript)
                {
                    string path = node.InnerText;
                    var jquery = new HtmlGenericControl("script");
                    jquery.Attributes["type"] = "text/javascript";
                    jquery.Attributes["src"] = ResolveUrl(path);
                    Page.Header.Controls.Add(jquery);
                    Page.Header.Controls.Add(new LiteralControl(Environment.NewLine));
                }
            }

            #endregion
            //}
            //else
            //{
            //    Response.Redirect(AdminPath + "Account/login.aspx");
            //}
        }
    }
}