using System;
using HC.Foundation.Page;
using HC.Framework.Helper;

namespace HC.WebSite
{
    public partial class RightMain : AdminPage
    {
        protected string Log { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var log = Server.MapPath("~/History/log.txt");
                var lines = FileHelper.ReadFileForLines(log);
                lines.Reverse();
                foreach (string line in lines)
                {
                    var arr = line.Split('#');
                    if (arr.Length == 2)
                    {
                        Log += string.Format("<li><span class='log_date'>{0}</span><span class='log_title'>{1}</span></li>", arr[0].Trim(), arr[1].Trim());
                    }
                }
            }
        }
    }
}