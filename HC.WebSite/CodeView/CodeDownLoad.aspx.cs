using System;
using System.IO;
using System.Web;
using HC.Foundation.Page;
using HC.Framework.Extension;
using HC.Framework.Helper;

namespace HC.WebSite.CodeView
{
    public partial class CodeDownLoad : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Response.Clear();
                string path = RequestString("path");
                if (path.IsNotEmpty())
                {
                    var directory = new DirectoryInfo(Server.MapPath("~/CodeView/Source"));
                    path = Path.Combine(directory.FullName, path.TrimStart('\\'));
                    if (Directory.Exists(path))
                    {
                        var zipDir = new DirectoryInfo(path);
                        string fileName = zipDir.Name + ".zip";
                        string targetPhysicalPath = HttpContext.Current.Server.MapPath("~/Temp");
                        targetPhysicalPath = Path.Combine(targetPhysicalPath, fileName);

                        if (ZipUtil.CreateZip(path, targetPhysicalPath))
                        {
                            WriteFile("~/Temp/" + fileName);
                        }
                        else
                        {
                            Response.Write("系统异常，请联系平台开发人员！");
                        }
                    }
                    else
                    {
                        Response.Write(string.Format("对不起，文件目录：{0} 不存在！", path));
                    }
                }
                else
                {
                    Response.Write("参数错误");
                }
                Response.End();
            }
        }

        /// <summary>
        /// 使用WriteFile下载文件  
        /// </summary>
        /// <param name="filePath">相对路径</param>
        public void WriteFile(string filePath)
        {
            Response.Redirect(filePath);
        }
    }
}