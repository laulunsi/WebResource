using System;
using System.IO;
using System.Web;
using HC.Foundation.Page;
using HC.Framework.Helper;

namespace HC.WebSite.CodeView
{
    public partial class CodeView : AdminPage
    {
        protected string FileContent { get; set; }
        protected string CodeModel { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string filePath = HttpUtility.UrlDecode(Request.QueryString["path"]);
                if (!string.IsNullOrEmpty(filePath))
                {
                    string jsDemoDirPath = Server.MapPath("~/CodeView/Source");
                    filePath = Path.Combine(jsDemoDirPath, filePath.TrimStart('\\'));
                    if (File.Exists(filePath))
                    {
                        if (!string.IsNullOrEmpty(Request.Form["content"]))
                        {
                            Response.Clear();
                            FileHelper.WriteFile(filePath, HttpUtility.UrlDecode(Request.Form["content"]));
                            Response.Write("ok");
                            Response.End();
                        }
                        string exsition = Path.GetExtension(filePath);
                        if (exsition != null)
                        {
                            exsition = exsition.Replace(".", "");
                            switch (exsition.ToLower())
                            {
                                case "htm":
                                case "html":
                                    CodeModel = "text/html";
                                    break;
                                case "js":
                                    CodeModel = "text/javascript";
                                    break;
                                case "css":
                                    CodeModel = "text/css";
                                    break;
                                case "cs":
                                    //CodeModel = "text/x-csharp";
                                    break;
                                default:
                                    CodeModel = "text/html";
                                    break;
                            }
                        }
                        FileContent = FileHelper.ReadFile(filePath);
                    }
                    else
                    {
                        FileContent = string.Format("对不起，文件：{0}不存在!", filePath);
                    }
                }
                else
                {
                    FileContent = string.Empty;
                    CodeModel = "text/html";
                }
            }
        }
    }
}