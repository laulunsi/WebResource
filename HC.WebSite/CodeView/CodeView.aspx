<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CodeView.aspx.cs" Inherits="HC.WebSite.CodeView.CodeView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <!--css-->
    <link rel="stylesheet" href="<%=BasePath %>Scripts/codemirror-3.16/lib/codemirror.css"
        type="text/css" />
    <link href="<%=BasePath %>Style/whir.common.css" rel="stylesheet" type="text/css" />
    <%--js--%>
    <script src="<%=BasePath %>CodeView/CodeMirror/codemirror.js" type="text/javascript"></script>
    <script src="<%=BasePath %>CodeView/CodeMirror/mirrorframe.js" type="text/javascript"></script>
    <form id="form1" runat="server">
    <style type="text/css">
        #templateul { width: 98%; margin-left: -40px; }
        #templateul li { padding: 5px; border-bottom: 1px dashed lightgray; height: 40px; }
        #templateul li:hover { padding: 5px; border-bottom: 1px dashed lightgray; height: 40px; background-color: lavender; }
        .file_title { font-weight: bold; }
        a:link { color: #000000; text-decoration: none; }
        a:visited { color: #000000; text-decoration: none; }
        a:hover { color: #000000; text-decoration: none; }
        a:active { color: #000000; text-decoration: none; }
        #txtKeyword { font-family: 微软雅黑; font-weight: bold; width: 400px; padding: 5px; border: 1px solid #d8d8d8; }
    </style>
    <div class="right_main">
        <fieldset class="demo_title">
            代码搜索:
            <input type="text" class="text" id="txtKeyword" placeholder="请输入查询关键字" value="" />
            <input type="button" id="btnSearch" value="搜索" class="btn" />
            <script type="text/javascript">
                $(function () {
                    //搜索按钮
                    $("#btnSearch").click(function () {
                        window.location.href = "CodeSearch.aspx?q=" + $("#txtKeyword").val();
                    });
                });
            </script>
        </fieldset>
        <fieldset class="demo_content">
            <textarea id="content" name="content"><%= FileContent %>    </textarea>
            <script type="text/javascript">
                var editer;
                $(function () {
                    //初始化代码编辑器
                    var editor = CodeMirror.fromTextArea('content', {
                        parserfile: ["tokenizecsharp.js", "parsecsharp.js"],
                        stylesheet: "<%=BasePath %>CodeView/CodeMirror/csharpcolors.css",
                        path: "<%=BasePath %>CodeView/CodeMirror/",
                        height: "500px",
                        indentUnit: 4
                    });
                });
            </script>
        </fieldset>
    </div>
    </form>
</body>
</html>
