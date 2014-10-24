<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jQueryDemoAddDemo.aspx.cs"
    Inherits="HC.WebSite.jQueryDemoManage.AddDemo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="padding: 2px 8px 0px 8px; margin: 0px; text-decoration: none; line-height: 150%;">
    <form id="form1" runat="server">
    <div class="right_main">
        <fieldset class="demo_title">
            添加实例
        </fieldset>
        <fieldset class="demo_content">
            为了保证jQuery Demo实例的格式统一，方便使用者查阅。请下载Demo模板后，请根据模板的文件结构制作Demo， <a href="<%=BasePath %>Template/demo.rar">
                Demo模板下载</a>
        </fieldset>
        <fieldset class="demo_content">
            <legend>模板结构说明</legend>
            <p>
                01.目录结构</p>
            <img src="<%=BasePath %>Style/images/demo.png" />
            <p>
                02.index.htm文件</p>
            <img src="<%=BasePath %>Style/images/index.png" />
            <br />
            <br />
        </fieldset>
    </div>
    </form>
</body>
</html>
