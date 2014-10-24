<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="XmlFormater.aspx.cs" Inherits="HC.WebSite.DataFormat.XmlFormater" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <!--css-->
    <link rel="stylesheet" href="<%=BasePath %>Scripts/codemirror-3.16/lib/codemirror.css"
        type="text/css" />
    <%--js--%>
    <script src="<%=BasePath %>Scripts/codemirror-3.16/lib/codemirror.js" type="text/javascript"> </script>
    <script src="<%=BasePath %>Scripts/codemirror-3.16/mode/css/css.js" type="text/javascript"> </script>
    <script src="<%=BasePath %>Scripts/codemirror-3.16/mode/xml/xml.js" type="text/javascript"> </script>
    <script src="<%=BasePath %>Scripts/codemirror-3.16/mode/javascript/javascript.js"
        type="text/javascript"> </script>
    <script src="<%=BasePath %>Scripts/codemirror-3.16/mode/htmlmixed/htmlmixed.js" type="text/javascript"> </script>
    <script src="<%=BasePath %>Scripts/codemirror-3.16/addon/edit/closetag.js" type="text/javascript"> </script>
    <script src="<%=BasePath %>Scripts/codemirror-3.16/addon/selection/active-line.js"
        type="text/javascript"> </script>
    <script src="<%=BasePath %>Scripts/codemirror-3.16/addon/edit/matchbrackets.js" type="text/javascript"> </script>
    <script src="<%=BasePath %>Scripts/codemirror-3.16/keymap/extra.js" type="text/javascript"> </script>
    <form id="form1" runat="server">
    <div id="mainForm" class="right_main">
        <style type="text/css">
            .CodeMirror { margin-top: 0px; height: 200px; font-size: 14px; }
        </style>
        <fieldset id="fieldsetTitle" class="demo_title">
            XML格式化
        </fieldset>
        <fieldset class="demo_content">
            <legend>输入： </legend>
            <textarea id="input" style="height: 200px; width: 99%"></textarea>
        </fieldset>
        <fieldset class="demo_content">
            <legend>操作选项</legend><span id="codeMaker_selectOptin"></span>
            <input type="button" id="btnFormat" value="格式化" />
        </fieldset>
        <fieldset class="demo_content output">
            <legend>输出：</legend>
            <textarea id="output">
            </textarea>
        </fieldset>
    </div>
    <script type="text/javascript">
        var editerInput;
        var editerOutput;
        $(function () {
            //初始化代码编辑器
            editerInput = CodeMirror.fromTextArea(document.getElementById("input"), {
                mode: "xml",
                autoCloseTags: true, //自动关闭标签
                lineNumbers: true, //显示行号
                styleActiveLine: true, //高亮选中行
                matchBrackets: true,
                lineWrapping: false  //自动换行
            });
            editerOutput = CodeMirror.fromTextArea(document.getElementById("output"), {
                mode: "xml",
                autoCloseTags: true, //自动关闭标签
                lineNumbers: true, //显示行号
                styleActiveLine: true, //高亮选中行
                matchBrackets: true,
                lineWrapping: false  //自动换行
            });

            //格式化
            $("#btnFormat").click(function () {
                var input = editerInput.getValue();
                if (input.length > 0) {
                    $.whir.ajax('DataFormatHandler.HtmlFormat', {
                        params: {
                            input: escape(input)
                        },
                        success: function (response) {
                            var data = eval(response)[0];
                            var status = data.status;
                            var result = data.result;
                            switch (status.toLowerCase()) {
                                case "true":
                                    $("#output").val(result);
                                    $(".output").find(".CodeMirror").remove();//清理多余的编辑器
                                    editerOutput = CodeMirror.fromTextArea(document.getElementById("output"), {
                                        mode: "xml",
                                        autoCloseTags: true, //自动关闭标签
                                        lineNumbers: true, //显示行号
                                        styleActiveLine: true, //高亮选中行
                                        matchBrackets: true,
                                        lineWrapping: false  //自动换行
                                    });
                                    break;
                                default:
                                    AlertErrorMsg(result);
                                    break;
                            }
                        }
                    });
                } else {
                    AlertErrorMsg("请输入内容！");
                }
            });

        });
    </script>
    </form>
</body>
</html>
