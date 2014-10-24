using System;
using System.IO;
using System.Text;
using System.Web;
using HC.Foundation.Page;
using HC.Framework.Helper;

namespace HC.WebSite.CodeView
{
    public partial class CodeGuide : AdminPage
    {
        protected string FileTreeHtml { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var directory = new DirectoryInfo(HttpContext.Current.Server.MapPath("~/CodeView/Source"));
                if (Directory.Exists(directory.FullName))
                {
                    FileTreeHtml = FileHelper.GetGuideTree(new StringBuilder(), directory.FullName, directory.FullName);
                }
            }
        }
    }
}