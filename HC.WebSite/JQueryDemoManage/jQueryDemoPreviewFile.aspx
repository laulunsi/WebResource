<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jQueryDemoPreviewFile.aspx.cs" Inherits="HC.WebSite.jQueryDemoManage.PreviewFile" %>

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
    <div class="right_main">
        <textarea id="content" name="content"><%= FileContent %>    </textarea>
        <input type="button" value="保存" class="btnEdit" />
        <script type="text/javascript">
            var editer;
            $(function () {
                //初始化代码编辑器
                editer = CodeMirror.fromTextArea(document.getElementById("content"), {
                    mode: "<%= CodeModel %>",
                    autoCloseTags: true, //自动关闭标签
                    lineNumbers: true, //显示行号
                    styleActiveLine: true, //高亮选中行
                    matchBrackets: true,
                    lineWrapping: false  //自动换行
                });

                //点击保存
                $(".btnEdit").click(function () {
                    var content = editer.getValue();
                    ConfirmDialog('确定保存对当前模板的修改吗？', function () {
                        var data = {
                            content: encodeURIComponent(content)
                        };
                        $.ajax({
                            type: "POST",
                            url: "<%=BasePath %>JQueryDemoManage/PreviewFile.aspx<%= HttpContext.Current.Request.Url.Query %>",
                            data: data,
                            success: function (msg) {
                                if (msg == "ok") {
                                    AlertSuccessMsg("操作成功！");
                                    window.location.href = window.location.href;
                                } else {
                                    AlertErrorMsg("保存失败：" + msg, 3, 'alert.gif');
                                }
                            },
                            err: function (msg) {
                                AlertErrorMsg("异常：" + msg, 3, 'alert.gif');
                            }
                        });
                    }, function () {
                    });
                });
            });

        </script>
    </div>
    </form>
</body>
</html>
