<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataBaseSchemaGuide.aspx.cs"
    Inherits="HC.WebSite.DataBaseTools.DataBaseSchemaGuide" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <style type="text/css">
        .tableItem { margin: 0px 0px 5px 0px !important; background: url(<%=BasePath%>Style/images/grid.png) no-repeat !important; padding: 1px 0 2px 20px !important; cursor: pointer; }
        .server { margin: 0px 0px 5px 0px; background: url(<%=BasePath%>Style/images/database.png) no-repeat !important; padding: 1px 0 2px 20px !important; cursor: pointer; }
        .selected { color: red; }
        .fieldItem { padding-left: 20px !important; background: url(<%=BasePath%>Style/images/text_columns.png) no-repeat !important; }
    </style>
    <div id="left_guide_title">
        数据库服务器<span class="tip">操作提示</span>
    </div>
    <div id="left_guide_content">
        <div class="mainContent">
            <ul id="fileList" class="filetree" style="padding: 5px 0px 0px 10px;">
                <li class="server"><span class="serverName">
                    <% =ServerName%></span> </li>
                <%= GuideTreeHtml %>
            </ul>
            <%--上下文菜单--%>
            <div class="contextMenu" id="contextMenu">
                <ul>
                    <li id="top200">
                        <img style="width: 18px; height: 16px;" src="<%=BasePath %>Style/images/lightning.png"
                            alt="" />
                        选择前200行</li>
                    <li id="customQuery">
                        <img style="width: 18px; height: 16px;" src="<%=BasePath %>Style/images/find.png"
                            alt="" />
                        自定义查询</li>
                    <li id="schema">
                        <img style="width: 18px; height: 16px;" src="<%=BasePath %>Style/images/page_white_word.png"
                            alt="" />
                        查看表结构</li>
                    <li id="createTable">
                        <img style="width: 18px; height: 16px;" src="<%=BasePath %>Style/images/grid.png"
                            alt="" />
                        快速建表</li>
                </ul>
            </div>
            <div class="contextMenu" id="DbContextMenu">
                <li id="close">
                    <img style="width: 18px; height: 16px;" src="<%=BasePath %>Style/images/cross.png"
                        alt="" />
                    关闭连接</li>
            </div>
            <script type="text/javascript">
                $(function () {

                    //树形文件目录
                    $(".filetree").treeview({
                        animated: "fast",
                        collapsed: true
                    });

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


                    //显示ToolTips
                    $(document).tooltip({
                        items: ".file",
                        track: true,
                        content: function () {
                            var element = $(this);
                            var name = element.attr("name");
                            var img = element.attr("img");
                            if (img != "") {
                                return "<img class='toolTips' alt='" + name + "' src='" + img + "'>";
                            }
                            return "";
                        }
                    });
                    //点击树形文件菜单 
                    $(".tableItem").click(function () {
                        $(this).addClass("selected");
                        $(this).parent().siblings().find("span").removeClass("selected");
                    });

                    $('.serverName').contextMenu('DbContextMenu', {
                        bindings: {
                            'close': function (t) {
                                window.location.href = "DataBaseGuide.aspx";
                            }
                        }
                    });
                    //响应右键菜单
                    $('.tableItem').contextMenu('contextMenu', {
                        bindings: {
                            'top200': function (t) {
                                $(t).addClass("selected");
                                $(t).parent().siblings().find("span").removeClass("selected");
                                var url = "<%=BasePath %>DataBaseTools/DataBaseQuery.aspx?action=top200&dbId=" + $(t).attr("dbId") + "&tableName=" + encodeURIComponent($(t).attr("tableName"));
                                OpenUrl(url);
                            },
                            'customQuery': function (t) {
                                $(t).addClass("selected");
                                $(t).parent().siblings().find("span").removeClass("selected");
                                var url = "<%=BasePath %>DataBaseTools/DataBaseQuery.aspx?action=customQuery&dbId=" + $(t).attr("dbId") + "&tableName=" + encodeURIComponent($(t).attr("tableName"));
                                OpenUrl(url);
                            },
                            'schema': function (t) {
                                $(t).addClass("selected");
                                $(t).parent().siblings().find("span").removeClass("selected");
                                var url = "<%=BasePath %>DataBaseTools/DataBaseSchema.aspx?action=schema&dbId=" + $(t).attr("dbId") + "&tableName=" + encodeURIComponent($(t).attr("tableName"));
                                OpenUrl(url);
                            },
                            'createTable': function (t) {
                                $(t).addClass("selected");
                                $(t).parent().siblings().find("span").removeClass("selected");
                                var url = "<%=BasePath %>DataBaseTools/DataBaseCreateTable.aspx?action=document&dbId=" + $(t).attr("dbId") + "&tableName=" + encodeURIComponent($(t).attr("tableName"));
                                OpenUrl(url);
                            }
                        }
                    });
                });

                function OpenUrl(url) {
                    var temp = parent.document.getElementById("right");
                    temp.src = url;
                    temp.contentWindow.window.name = "right";
                    parent.frames["right"] = temp.contentWindow.window;
                }

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
