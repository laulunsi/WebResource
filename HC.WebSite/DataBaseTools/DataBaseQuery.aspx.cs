using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using HC.Foundation.Page;
using HC.Framework.DataBase;
using HC.Framework.DataBase.DBManager;
using HC.Framework.DataBase.DBManager.Model;
using HC.Framework.Helper;

namespace HC.WebSite.DataBaseTools
{
    public partial class DataBaseQuery : AdminPage
    {
        protected string Html { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (RequestInt32("dbId") > 0)
                {
                    string configText = ConfigHelper.ReadConfig<DbConnection>();
                    if (!string.IsNullOrEmpty(configText))
                    {
                        var dbs = (List<DbConnection>) ConfigHelper.Deserialize(typeof (List<DbConnection>), configText);
                        foreach (DbConnection connection in dbs)
                        {
                            if (RequestInt32("dbId") == connection.Id)
                            {
                                var con = new DbConnection
                                    {
                                        Server = connection.Server,
                                        DataBase = connection.DataBase,
                                        UserName = connection.UserName,
                                        Password = connection.Password,
                                        Id = connection.Id
                                    };
                                Html = GetFieldTable(con);
                                break;
                            }
                        }
                    }
                }
            }
        }

        public string GetFieldTable(DbConnection connection)
        {
            var html = new StringBuilder();
            html.Append("可用变量：").Append(Environment.NewLine);
            string tableName = HttpUtility.UrlDecode(RequestString("tableName"));
            List<FieldInfo> fields = DBManager.GetFieldInfoList(tableName, connection.GetConnection());
            foreach (FieldInfo fieldInfo in fields)
            {
                html.AppendFormat("<span class='fieldselect'>{0}</span>", fieldInfo.Name);
            }
            return html.ToString();
        }
    }
}