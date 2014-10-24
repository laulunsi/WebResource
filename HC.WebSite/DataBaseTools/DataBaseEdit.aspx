<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataBaseEdit.aspx.cs" Inherits="HC.WebSite.DataBaseTools.DataBaseEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="demo_main">
        <style type="text/css">
            table { border: 0px !important; }
            th { border: 1px solid gray !important; background-color: #D3D8E0; }
            td { border: 0 !important; }
            .td_left { border-left: 1px solid gray !important; }
            .td_right { border-right: 1px solid gray !important; }
            .td_bottom { border-right: 1px solid gray !important; border-left: 1px solid gray !important; border-bottom: 1px solid gray !important; }
            .text { padding-left: 6px; }
        </style>
        <fieldset class="demo_title">
            编辑数据库链接
        </fieldset>
        <fieldset class="demo_content">
            <table>
                <tr align="center">
                    <th class="th_title" colspan="2" style="">
                        数据库链接配置
                    </th>
                </tr>
                <tr>
                    <td class="td_left" style="text-align: right">
                        连接名称：
                    </td>
                    <td class="td_right">
                        <asp:TextBox ID="txtName" CssClass="text" autocomplete="off" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" CssClass="required" runat="server"
                            ErrorMessage="*" ControlToValidate="txtName">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="td_left" style="text-align: right">
                        服务器地址：
                    </td>
                    <td class="td_right">
                        <asp:TextBox ID="txtServer" CssClass="text" autocomplete="off" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="required" runat="server"
                            ErrorMessage="*" ControlToValidate="txtServer">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="td_left" style="text-align: right">
                        数据库名：
                    </td>
                    <td class="td_right">
                        <asp:TextBox ID="txtDataBase" CssClass="text" autocomplete="off" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="required" runat="server"
                            ErrorMessage="*" ControlToValidate="txtDataBase">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="td_left" style="text-align: right">
                        用户名：
                    </td>
                    <td class="td_right">
                        <asp:TextBox ID="txtUserName" CssClass="text" autocomplete="off" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" CssClass="required" runat="server"
                            ErrorMessage="*" ControlToValidate="txtUserName">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="td_left" style="text-align: right">
                        密&nbsp;&nbsp;码：
                    </td>
                    <td class="td_right">
                        <asp:TextBox ID="txtPassword" TextMode="Password" autocomplete="off" CssClass="text"
                            runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" CssClass="required" runat="server"
                            ErrorMessage="*" ControlToValidate="txtPassword">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="td_left" style="text-align: right">
                    </td>
                    <td class="td_right">
                        <asp:Button runat="server" ID="btnSubmit" OnClick="btnSubmit_click" Text="保存" />
                        <asp:Button runat="server" ID="btnReturn" OnClick="btnReturn_click" Text="返回" CausesValidation="False" />
                        <input type="button" id="btnTest" value="测试" />
                    </td>
                </tr>
                <tr>
                    <td class="td_bottom" colspan="2" align="center">
                        （数据库密码加密存储，修改时未加载初始值，若左侧导航树中您的数据库能链接成功，则无需更改，请点击"返回"按钮）
                    </td>
                </tr>
            </table>
        </fieldset>
    </div>
    <script type="text/javascript">
        $(function () {
            $("#btnTest").click(function () {
                var server = $("#<%=txtServer.ClientID%>").val();
                var dataBase = $("#<%=txtDataBase.ClientID%>").val();
                var userName = $("#<%=txtUserName.ClientID%>").val();
                var pwd = $("#<%=txtPassword.ClientID%>").val();
                if (server.length > 0 && dataBase.length > 0 && userName.length > 0 && pwd.length > 0) {
                    mask(true);
                    $.whir.ajax('DataBaseHandler.DbTest', {
                        params: {
                            server: escape(server),
                            dataBase: escape(dataBase),
                            userName: escape(userName),
                            pwd: escape(pwd)
                        },
                        success: function (response) {
                            var data = eval(response)[0];
                            var status = data.status;
                            var result = data.result;
                            switch (status.toLowerCase()) {
                                case "ok":
                                    AlertSuccessMsg("连接成功！");
                                    break;
                                default:
                                    AlertErrorMsg(result);
                                    break;
                            }
                            mask(false);
                            $("#btnTest").removeAttr("disabled");
                        }
                    });
                } else {
                    AlertErrorMsg("服务器地址，数据库名称，用户名，密码均不能为空！");
                }
            });
        });
    </script>
    </form>
</body>
</html>
