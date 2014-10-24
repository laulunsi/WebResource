using System;
using System.Collections.Generic;
using HC.Foundation.Page;
using HC.Framework.DataBase;
using HC.Framework.Helper;

namespace HC.WebSite.DataBaseTools
{
    public partial class DataBaseManage : AdminPage
    {
        public string ConfigFilePath = ConfigHelper.GetConfigPath<DbConnection>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PanNodata.Visible = false;
                string xml = ConfigHelper.ReadConfig<DbConnection>();
                if (!string.IsNullOrEmpty(xml))
                {
                    var dbs = (List<DbConnection>)ConfigHelper.Deserialize(typeof(List<DbConnection>), xml);
                    if (dbs.Count > 0)
                    {
                        repDbConections.DataSource = dbs;
                        repDbConections.DataBind();
                    }
                    else
                    {
                        PanNodata.Visible = true;
                    }
                }
                else
                {
                    PanNodata.Visible = true;
                }
            }
        }
    }
}