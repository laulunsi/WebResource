<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataBaseSchema.aspx.cs"
    Inherits="HC.WebSite.DataBaseTools.DataBaseSchema" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <style type="text/css">
        .td_field { padding-left: 5px; }
        .td_title { background: #D3D8E0; }
    </style>
    <div class="demo_main">
        <fieldset class="demo_title">
            数据表架构<span style="color: green">（请从左侧导航树上右键弹出菜单以进行操作）</span>
        </fieldset>
        <fieldset class="demo_content">
            <%=Html%>
        </fieldset>
    </div>
    </form>
</body>
</html>
