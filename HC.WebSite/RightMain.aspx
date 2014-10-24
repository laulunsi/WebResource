<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RightMain.aspx.cs" Inherits="HC.WebSite.RightMain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <style type="text/css">
        li { height: 25px; }
    </style>
    <form id="form1" runat="server">
    <div class="demo_main">
        <fieldset class="demo_title">
            欢迎来到“Web资源库”
        </fieldset>
        <fieldset class="demo_content">
            <ul>
                <li><b>平台简介：</b> Web资源库用于收集整理工作中常用到的实例Demo，功能实现代码，利于团队代码标准化和提高个人工作效率。 </li>
                <li><b>栏目说明：</b></li>
                <ul class="demo_content_items">
                    <li>01.<span class="title">jQuery实例库：</span>用于收集整理项目中经常使用的jQuery库Demo，支持Demo的在线预览，打包下载等操作。（右键左侧树形菜单，根据弹出菜单进行操作）</li>
                    <li>02.<span class="title">数据库工具：</span>提供一些简单常用的数据库在线操作</li>
                    <li>03.<span class="title">辅助工具：提供一些开发过程中常用到的在线工具</span></li>
                </ul>
            </ul>
        </fieldset>
        <fieldset class="demo_content">
            <legend>更新日志</legend>
            <ul>
                <%=Log %>
            </ul>
        </fieldset>
        <p class="feedback">
            若您有好的意见或建议，Email：zhangqs008@163.com</p>
    </div>
    </form>
</body>
</html>
