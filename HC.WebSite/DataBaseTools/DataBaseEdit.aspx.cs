using System;
using System.Collections.Generic;
using HC.Foundation.Page;
using HC.Framework.DataBase;
using HC.Framework.Helper;

namespace HC.WebSite.DataBaseTools
{
    public partial class DataBaseEdit : AdminPage
    {
        public string ConfigFilePath = ConfigHelper.GetConfigPath<DbConnection>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                #region 修改

                if (RequestInt32("id") > 0 & RequestString("action").ToLower() == "modify")
                {
                    string configText = ConfigHelper.ReadConfig<DbConnection>();
                    if (!string.IsNullOrEmpty(configText))
                    {
                        var dbs = (List<DbConnection>) ConfigHelper.Deserialize(typeof (List<DbConnection>), configText);
                        foreach (DbConnection connection in dbs)
                        {
                            if (RequestInt32("id") == connection.Id)
                            {
                                txtServer.Text = connection.Server;
                                txtDataBase.Text = connection.DataBase;
                                txtUserName.Text = connection.UserName;
                                //txtPassword.Text = connection.Password;
                                txtName.Text = connection.Name;
                                break;
                            }
                        }
                    }
                }

                #endregion

                #region 删除

                if (RequestInt32("id") > 0 & RequestString("action").ToLower() == "del")
                {
                    string configText = ConfigHelper.ReadConfig<DbConnection>();
                    var newDbs = new List<DbConnection>();
                    if (!string.IsNullOrEmpty(configText))
                    {
                        var dbs = (List<DbConnection>) ConfigHelper.Deserialize(typeof (List<DbConnection>), configText);
                        foreach (DbConnection connection in dbs)
                        {
                            if (RequestInt32("id") != connection.Id)
                            {
                                newDbs.Add(connection);
                            }
                        }
                    }
                    string xml = ConfigHelper.Serialize(newDbs);
                    ConfigHelper.WriteConfig(xml, ConfigFilePath);
                    Response.Redirect("DataBaseManage.aspx");
                }

                #endregion
            }
        }

        protected void btnSubmit_click(object sender, EventArgs e)
        {
            int maxId = 0;
            var dbs = new List<DbConnection>();
            string configText = ConfigHelper.ReadConfig<DbConnection>();
            if (!string.IsNullOrEmpty(configText))
            {
                dbs = (List<DbConnection>) ConfigHelper.Deserialize(typeof (List<DbConnection>), configText);
                if (RequestInt32("id") > 0)
                {
                    #region 修改

                    foreach (DbConnection connection in dbs)
                    {
                        if (RequestInt32("id") == connection.Id)
                        {
                            connection.Server = txtServer.Text.Trim();
                            connection.DataBase = txtDataBase.Text.Trim();
                            connection.UserName = txtUserName.Text.Trim();
                            connection.Password = DESCrypt.Encrypt(txtPassword.Text.Trim());
                            connection.Name = txtName.Text.Trim();
                            break;
                        }
                    }
                    string xml = ConfigHelper.Serialize(dbs);
                    ConfigHelper.WriteConfig(xml, ConfigFilePath);

                    #endregion
                }
                else
                {
                    #region 添加

                    var dbConnection = new DbConnection();
                    dbConnection.Server = txtServer.Text.Trim();
                    dbConnection.DataBase = txtDataBase.Text.Trim();
                    dbConnection.UserName = txtUserName.Text.Trim();
                    dbConnection.Password = txtPassword.Text.Trim();
                    dbConnection.Name = txtName.Text.Trim();
                    foreach (DbConnection connection in dbs)
                    {
                        if (maxId < connection.Id)
                        {
                            maxId = connection.Id;
                        }
                    }
                    dbConnection.Id = maxId + 1;
                    dbs.Add(dbConnection);
                    string xml = ConfigHelper.Serialize(dbs);
                    ConfigHelper.WriteConfig(xml, ConfigFilePath);

                    #endregion
                }
                Response.Redirect("DataBaseManage.aspx");
            }
            else
            {
                #region 初始化添加

                var dbConnection = new DbConnection();
                dbConnection.Id = maxId + 1;
                dbConnection.Server = txtServer.Text.Trim();
                dbConnection.DataBase = txtDataBase.Text.Trim();
                dbConnection.UserName = txtUserName.Text.Trim();
                dbConnection.Password = txtPassword.Text.Trim();
                dbConnection.Name = txtName.Text.Trim();
                dbs.Add(dbConnection);
                string xml = ConfigHelper.Serialize(dbs);
                ConfigHelper.WriteConfig(xml, ConfigFilePath);
                Response.Redirect("DataBaseManage.aspx");

                #endregion
            }
        }

        protected void btnReturn_click(object sender, EventArgs e)
        {
            Response.Redirect("DataBaseManage.aspx");
        }
    }
}