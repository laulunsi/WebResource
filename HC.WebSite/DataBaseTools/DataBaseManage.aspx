<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataBaseManage.aspx.cs"
    Inherits="HC.WebSite.DataBaseTools.DataBaseManage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <style type="text/css">
        .th_title { width: 15%;background-color: #D3D8E0; }
        .td_right { text-align: center; }
    </style>
    <div class="demo_main">
        <fieldset class="demo_title">
            <div class="operator">
                <input type="button" value="添加数据库链接" onclick="location.href='DataBaseEdit.aspx'" /></div>
            数据库管理
        </fieldset>
        <fieldset class="demo_content">
            <table>
                <tr>
                    <th class="th_title" style="width: 15%;">
                        Id
                    </th>
                    <th class="th_title" style="width: 15%;">
                        连接名称
                    </th>
                    <th class="th_title" style="width: 15%;">
                        服务器
                    </th>
                    <th class="th_title" style="width: 15%;">
                        数据库
                    </th>
                    <th class="th_title" style="width: 15%;">
                        用户名
                    </th>
                    <th class="th_title" style="width: 15%;">
                        操作
                    </th>
                </tr>
                <asp:Repeater runat="server" ID="repDbConections">
                    <ItemTemplate>
                        <tr>
                            <td class="td_right" style="width: 15%;">
                                <%#Eval("Id") %>
                            </td>
                               <td class="td_right" style="width: 15%;">
                                <%#Eval("Name") %>
                            </td>
                            <td class="td_right" style="width: 15%;">
                                <%#Eval("Server") %>
                            </td>
                            <td class="td_right" style="width: 15%;">
                                <%#Eval("DataBase") %>
                            </td>
                            <td class="td_right" style="width: 15%;">
                                <%#Eval("UserName") %>
                            </td>
                            <td class="td_right" style="width: 15%;">
                                <a href="DataBaseEdit.aspx?id=<%#Eval("Id") %>&action=modify">编辑</a> <a href="DataBaseEdit.aspx?id=<%#Eval("Id") %>&action=del">
                                    删除</a>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Panel runat="server" ID="PanNodata">
                    <tr>
                        <td colspan="6" align="center">
                            暂无任何数据
                        </td>
                    </tr>
                </asp:Panel>
            </table>
        </fieldset>
    </div>
    </form>
</body>
</html>
