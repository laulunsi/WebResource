<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="HC.WebSite._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Web资源库-点滴之水,汇聚江河</title>
</head>
<body>
    <style type="text/css">
        .footer { height: 25px; text-align: center; background: lavender; padding-top: 10px; }
    </style>
    <form id="form1" runat="server">
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;">
        <tr>
            <td colspan="3">
                <div id="header">
                    <!--一级菜单-->
                    <ul id="firstMenu">
                        <li id="jqueryDemo" class="jqueryDemo"><a href="javascript:"><span>jQuery实例库</span></a>
                        </li>
                        <li id="aspNetDemo" class="aspNetDemo"><a href="javascript:"><span>网页素材库</span></a>
                        </li>
                        <li id="sysLibrary" class="sysLibrary"><a href="javascript:"><span>类库源代码</span></a>
                        </li>
                        <li id="dataBase" class="dataBase"><a href="javascript:"><span>数据库工具</span></a>
                        </li>
                        <li id="dataFormat" class="dataFormat"><a href="javascript:"><span>辅助工具</span></a>
                        </li>
                    </ul>
                    <!--二级菜单-->
                    <div id="secondMenu">
                        <%-- jQuery实例库--%>
                        <div id="sub_jqueryDemo" style="display: none; width: 100%;">
                            <ul>
                                <li class="secondMenu"><a href="javascript:showUrl('/LeftGuide.aspx','RightMain.aspx')">
                                    平台首页</a> </li>
                                <li class="secondMenu"><a href="javascript:showUrl('/LeftGuide.aspx','/JQueryDemoManage/jQueryDemoAddDemo.aspx')"
                                    class="secondMenu_unselected">添加实例</a> </li>
                            </ul>
                        </div>
                        <%--网页小图标--%>
                        <div id="sub_aspNetDemo" style="display: none; width: 100%;">
                            <ul>
                                <li class="secondMenu"><a href="javascript:showUrl('/MaterialLibrary/MaterialGuide.aspx','/MaterialLibrary/MaterialPreview.aspx')">
                                    网页小图标</a> </li>
                            </ul>
                        </div>
                        <%--系统类库--%>
                        <div id="sub_sysLibrary" style="display: none; width: 100%;">
                            <ul>
                                <li class="secondMenu"><a href="javascript:showUrl('/CodeView/CodeGuide.aspx','/CodeView/CodeSearch.aspx')">
                                    类库源代码</a> </li>
                            </ul>
                        </div>
                        <%-- 数据库工具--%>
                        <div id="sub_dataBase" style="display: none; width: 100%;">
                            <ul>
                                <li class="secondMenu"><a href="javascript:showUrl('/DataBaseTools/DataBaseGuide.aspx?t=1','/DataBaseTools/DataBaseManage.aspx')">
                                    数据库管理</a> </li>
                                <li class="secondMenu"><a href="javascript:showUrl('/DataBaseTools/DataBaseGuide.aspx','/DataBaseTools/DataBaseSchema.aspx')"
                                    class="secondMenu_unselected">数据表架构</a> </li>
                                <li class="secondMenu"><a href="javascript:showUrl('/DataBaseTools/DataBaseGuide.aspx','/DataBaseTools/DataBaseQuery.aspx')"
                                    class="secondMenu_unselected">数据表数据</a> </li>
                                <li class="secondMenu"><a href="javascript:showUrl('/DataBaseTools/DataBaseGuide.aspx','/DataBaseTools/DataBaseCreateTable.aspx')">
                                    快速建表</a> </li>
                            </ul>
                        </div>
                        <%-- 辅助工具--%>
                        <div id="sub_dataFormat" style="display: none; width: 100%;">
                            <ul>
                                <li class="secondMenu"><a href="javascript:showUrl('/LeftGuide.aspx','/DataFormat/Json/index.htm')">
                                    JSON格式化</a> </li>
                                <li class="secondMenu"><a href="javascript:showUrl('/LeftGuide.aspx','/DataFormat/XmlFormater.aspx')"
                                    class="secondMenu_unselected">XML格式化</a> </li>
                                <li class="secondMenu"><a href="javascript:showUrl('/LeftGuide.aspx','/DataFormat/HtmlFormater.aspx')"
                                    class="secondMenu_unselected">HTML格式化</a> </li>
                                <li class="secondMenu"><a href="javascript:showUrl('/LeftGuide.aspx','/DataFormat/JavascriptFormater.aspx')">
                                    Javascript格式化</a> </li>
                            </ul>
                        </div>
                    </div>
                    <%--右上角链接--%>
                    <div class="topRightLink">
                        <span class="help">使用帮助</span> <span class="about">关于我们</span>
                    </div>
                </div>
            </td>
        </tr>
        <tr style="vertical-align: top;">
            <!--左侧导航-->
            <td id="frmTitle">
                <iframe tabid="1" frameborder="0" id="left" name="left" scrolling="auto" src="LeftGuide.aspx"
                    style="position: relative; visibility: inherit; width: 245px; z-index: 2;"></iframe>
            </td>
            <!--中间隔栏-->
            <td onclick=" switchSysBar(); " id="splitLine">
            </td>
            <!--右边页面-->
            <td>
                <div id="main_right">
                    <iframe id="right" name="main_right" frameborder="0" scrolling="auto" src="RightMain.aspx">
                    </iframe>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <div class="footer">
                   <a href="http://www.miitbeian.gov.cn/" target="_blank">粤ICP备14030001号</a></div>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        $(function () {
            $(".help").click(function () {
                mask(true);
                $.dialog({
                    title: "使用帮助",
                    content: 'url:<%=BasePath %>Demo/index.htm',
                    width: 860,
                    height: 490,
                    close: function () { mask(false); }
                });
            });

            $(".about").click(function () {
                mask(true);
                $.dialog({
                    title: "关于我们",
                    content: 'url:<%=BasePath %>Demo/about.htm',
                    width: 860,
                    height: 450,
                    max: false,
                    min: false,
                    close: function () { mask(false); }
                });
            });

            //初次时弹出“使用帮助”
            var showHelp = getCookie("showHelp");
            if (showHelp != "1") {
                mask(true);
                $.dialog({
                    title: "欢迎来到 Web资源库 新手上路",
                    content: 'url:<%=BasePath %>Demo/index.htm',
                    width: 860,
                    height: 490,
                    close: function () { mask(false); }
                });
                setCookie("showHelp", "1", 3);
            }
        });
    </script>
    </form>
</body>
</html>
