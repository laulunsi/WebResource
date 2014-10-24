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
    public partial class DataBaseSchema : AdminPage
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
                        var dbs = (List<DbConnection>)ConfigHelper.Deserialize(typeof(List<DbConnection>), configText);
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
            html.Append("<table>").Append(Environment.NewLine);
            html.Append("   <tr>").Append(Environment.NewLine);
            html.Append("       <th class='td_title'>排序</th>").Append(Environment.NewLine);
            html.Append("       <th class='td_title'>主键</th>").Append(Environment.NewLine);
            html.Append("       <th class='td_title'>字段名</th>").Append(Environment.NewLine);
            html.Append("       <th class='td_title'>字段类型</th>").Append(Environment.NewLine);
            html.Append("       <th class='td_title'>长度</th>").Append(Environment.NewLine);
            html.Append("       <th class='td_title'>ISNULL</th>").Append(Environment.NewLine);
            html.Append("       <th class='td_title'>备注</th>").Append(Environment.NewLine);
            html.Append("   </tr>").Append(Environment.NewLine);
            var tableName = HttpUtility.UrlDecode(RequestString("tableName"));
            var tableChineseName = DBManager.GetTableChineseName(tableName, connection.GetConnection());
            var fields = DBManager.GetFieldInfoList(tableName, connection.GetConnection());
            var count = 0;
            foreach (FieldInfo fieldInfo in fields)
            {
                count++;
                html.Append("   <tr>");
                html.Append("       <td class='td_field'>" + count + "</td>");
                html.Append("       <td class='td_field'>" + (fieldInfo.IsPrimaryKey ? "√" : "") + "</td>");
                html.Append("       <td class='td_field'>" + fieldInfo.Name + "</td>");
                html.Append("       <td class='td_field'>" + fieldInfo.Type + "</td>");
                html.Append("       <td class='td_field'>" + fieldInfo.Length + "</td>");
                html.Append("       <td class='td_field'>" + (fieldInfo.IsAllowNull ? "√" : "") + "</td>");
                html.Append("       <td class='td_field'>" + fieldInfo.Note + "</td>");
                html.Append("   </tr>");
            }
            html.Append("   <tr>");
            html.Append("        <td  class='td_title' style='text-align: center;' ><b>数据表名</b></td>");
            html.Append("        <td  class='td_field' style='text-align: center;' colspan='" + (count - 1) + "'>" + tableName + "-" + tableChineseName + "</td>");
            html.Append("   </tr>");
            html.Append("</table>").Append(Environment.NewLine);
            return html.ToString();
        }
    }
}