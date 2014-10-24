using System;
using System.IO;
using System.Web;
using HC.Foundation.Page;

namespace HC.WebSite.jQueryDemoManage
{
    public partial class PreviewDirectory : AdminPage
    {
        protected string FileContent { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            string filePath = HttpUtility.UrlDecode(RequestString("path"));
            if (!string.IsNullOrEmpty(filePath))
            {
                var directory = new DirectoryInfo(HttpContext.Current.Server.MapPath("~/jQueryDemos"));
                var path = Path.Combine(directory.FullName, filePath.TrimStart('\\'));
                if (path.EndsWith(".htm"))
                {
                    if (File.Exists(path))
                    {
                        var url = "~/jQueryDemos/" + filePath;
                        url = url.Replace("\\", "/").Replace("//", "/");
                        Response.Redirect(url);
                    }
                    else
                    {
                        FileContent = "对不起，该文件不存在";
                    }
                }
                else
                {
                    path = Path.Combine(path, "index.htm");
                    if (File.Exists(path))
                    {
                        var url = "~/jQueryDemos/" + filePath + "/index.htm";
                        url = url.Replace("\\", "/").Replace("//", "/");
                        Response.Redirect(url);
                    }
                    else
                    {
                        FileContent = "对不起，该目录下没有可预览的文件，如需查看单个文件，请点击导航树文件，谢谢";
                    }
                }
            }
            else
            {
                FileContent = string.Empty;
            }
        }
    }
}