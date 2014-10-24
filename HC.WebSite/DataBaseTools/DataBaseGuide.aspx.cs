using System;
using System.Collections.Generic;
using HC.Foundation.Page;
using HC.Framework.DataBase;
using HC.Framework.Helper;

namespace HC.WebSite.DataBaseTools
{
    public partial class DataBaseGuide : AdminPage
    {
        protected string ConnectionItems { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string xml = ConfigHelper.ReadConfig<DbConnection>();
                if (!string.IsNullOrEmpty(xml))
                {
                    var dbs = (List<DbConnection>)ConfigHelper.Deserialize(typeof(List<DbConnection>), xml);
                    foreach (DbConnection connection in dbs)
                    {
                        ConnectionItems += "<li class='dbItem' dbId='" + connection.Id + "'>" + connection.Name + "</li>";
                    }
                }
            }
        }
    }
}