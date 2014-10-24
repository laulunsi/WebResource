using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using HC.Foundation.Page;
using HC.Framework.DataBase;
using HC.Framework.DataBase.DBManager;
using HC.Framework.DataBase.DBManager.Model;
using HC.Framework.Helper;

namespace HC.WebSite.DataBaseTools
{
    public partial class DataBaseSchemaGuide : AdminPage
    {
        protected string GuideTreeHtml { get; set; }
        protected string ServerName { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (RequestInt32("id") > 0)
                {
                    string configText = ConfigHelper.ReadConfig<DbConnection>();
                    if (!string.IsNullOrEmpty(configText))
                    {
                        var dbs = (List<DbConnection>)ConfigHelper.Deserialize(typeof(List<DbConnection>), configText);
                        foreach (DbConnection connection in dbs)
                        {
                            if (RequestInt32("id") == connection.Id)
                            {
                                var con = new DbConnection
                                    {
                                        Server = connection.Server,
                                        DataBase = connection.DataBase,
                                        UserName = connection.UserName,
                                        Password = connection.Password,
                                        Id = connection.Id
                                    };
                                ServerName = connection.Name + "(" + connection.Server + ")";
                                GuideTreeHtml = GetDataBaseTables(con);
                                break;
                            }
                        }
                    }
                }
            }
        }

        public string GetDataBaseTables(DbConnection connection)
        {
            var conStatus = DBManager.CheckConnection(connection.GetConnection());
            if (conStatus.IsSucess)
            {
                try
                {
                    var tableBuilder = new StringBuilder();
                    if (!string.IsNullOrEmpty(connection.DataBase))
                    {
                        DataTable tables = DBManager.GetTables(connection.DataBase, connection.GetConnection());
                        foreach (DataRow row in tables.Rows)
                        {
                            var fields = DBManager.GetFieldInfoList(row["表名"].ToString(), connection.GetConnection());
                            var fieldsString = new StringBuilder();
                            foreach (FieldInfo field in fields)
                            {
                                fieldsString.Append("<li><span class='fieldItem'>" + field.Name + "(" + field.Type + "(" + field.Length + ")" + ")</span></li>");
                            }
                            tableBuilder.AppendFormat(
                                "<li class='li_tableItem' >" +
                                "   <span class='tableItem' dbId='{1}' tableName='{0}' values='{0}' title='{0}'>{0}</span>" +
                                "   <ul>" +
                                      fieldsString +
                                "   </ul>" +
                                "</li>",
                                row["表名"], connection.Id);
                        }
                        return tableBuilder.ToString();
                    }
                }
                catch (Exception ex)
                {
                    return "异常：" + ex.Message;
                }
            }
            else
            {
                return "数据库连接失败：" + conStatus.Message;
            }
            return string.Empty;
        }
    }
}