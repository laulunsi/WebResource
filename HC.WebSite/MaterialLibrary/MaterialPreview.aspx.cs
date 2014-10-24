using System;
using System.IO;
using System.Web;
using HC.Foundation.Page;

namespace HC.WebSite.MaterialLibrary
{
    public partial class MaterialPreview : AdminPage
    {
        protected string Html { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string filePath = HttpUtility.UrlDecode(Request.QueryString["path"]);
                if (!string.IsNullOrEmpty(filePath))
                {
                    string jsDemoDirPath = Server.MapPath("~/MaterialFiles");
                    var physicalFilePath = Path.Combine(jsDemoDirPath, filePath.TrimStart('\\'));
                    if (Directory.Exists(physicalFilePath))
                    {
                        Html += "<ul class='imgul'>";
                        var dir = new DirectoryInfo(physicalFilePath);
                        foreach (FileInfo file in dir.GetFiles())
                        {
                            Html += string.Format("<li><img src='{0}' title='{1}' class='imgItem'></li>",
                                                  (BasePath + "MaterialFiles/" + filePath.Replace("\\", "/") + "/" + file.Name).Replace("//", "/"), file.Name);
                        }
                        Html += "</ul>";
                    }
                }
            }
        }
    }
}