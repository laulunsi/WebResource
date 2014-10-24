<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataBaseGuide.aspx.cs"
    Inherits="HC.WebSite.DataBaseTools.DataBaseGuide" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <style type="text/css">
        .dbItem { margin: 0px 0px 5px 0px; background: url(<%=BasePath%>Style/images/database.png) no-repeat; padding: 1px 0 2px 20px !important; cursor: pointer; }
        .selected { color: red; font-weight: bold; }
    </style>
    <div id="left_guide_title">
        数据库服务器<span class="tip">操作提示</span>
    </div>
    <div id="left_guide_content">
        <div class="mainContent">
            <ul id="fileList" class="filetree" style="margin-left: -25px;">
                <%= ConnectionItems %></ul>
            <%--上下文菜单--%>
            <div class="contextMenu" id="contextMenu">
                <ul>
                    <li id="con">
                        <img style="width: 18px; height: 16px;" src="<%=BasePath%>Scripts/jquery.treeview/images/lightning.png"
                            alt="" />
                        连接</li>
                    <li id="edit">
                        <img style="width: 18px; height: 16px;" src="<%=BasePath%>Style/images/hammer.png"
                            alt="" />
                        修改</li>
                    <li id="delete">
                        <img style="width: 18px; height: 16px;" src="<%=BasePath%>Scripts/jquery.treeview/images/delete.png"
                            alt="" />
                        删除</li>
                </ul>
            </div>
            <script type="text/javascript">
                $(function () {
                    //操作提示
                    $(".tip").click(function () {
                        mask(true);
                        $.dialog({
                            title: "使用帮助",
                            content: 'url:<%=BasePath %>Demo/index.htm',
                            width: 860,
                            height: 490,
                            close: function () { mask(false); }
                        });
                    });

                    //点击树形文件菜单 
                    $(".dbItem").click(function () {
                        $(this).addClass("selected");
                        $(this).siblings().removeClass("selected");
                    });

                    //响应右键菜单
                    $('.dbItem').contextMenu('contextMenu', {
                        bindings: {
                            'con': function (t) {
                                var path = "<%=BasePath %>DataBaseTools/DataBaseSchemaGuide.aspx?id=" + $(t).attr("dbid");
                                var url = path;
                                window.location.href = url;
                            },
                            'edit': function (t) {
                                var url = "<%=BasePath %>DataBaseTools/DataBaseEdit.aspx?action=modify&id=" + $(t).attr("dbid");
                                var temp = parent.document.getElementById("right");
                                temp.src = url;
                                temp.contentWindow.window.name = "right";
                                parent.frames["right"] = temp.contentWindow.window;
                            },
                            'delete': function (t) {
                                ConfirmDialog("确定要删除该记录吗？", function () {
                                    var url = "<%=BasePath %>DataBaseTools/DataBaseEdit.aspx?action=del&id=" + $(t).attr("dbid");
                                    var temp = parent.document.getElementById("right");
                                    temp.src = url;
                                    temp.contentWindow.window.name = "right";
                                    parent.frames["right"] = temp.contentWindow.window;
                                    window.location.href = window.location.href;
                                });
                            }
                        }
                    });
                });

                function GetRandomNum() {
                    var range = 1000;
                    var rand = Math.random();
                    return (Math.round(rand * range));
                }
            </script>
        </div>
    </div>
    </form>
</body>
</html>
