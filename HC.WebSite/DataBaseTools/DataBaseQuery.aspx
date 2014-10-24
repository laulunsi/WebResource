<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataBaseQuery.aspx.cs"
    Inherits="HC.WebSite.DataBaseTools.DataBaseQuery" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <style type="text/css">
        .result { max-height: 400px; max-width: 100%; overflow: auto; }
        .data_th { background-color: #D3D8E0; }
        .data_td { padding-left: 5px; }
        #input { height: 100px !important; }
        .fieldselect { display: inline-block; min-width: 50px; border: 1px dashed gray; text-align: center; background: #D3D8E0; margin-right: 5px; cursor: pointer; border-radius: 4px; padding: 2px; margin-bottom: 5px; }
        .fieldselect:hover { display: inline-block; min-width: 50px; border: 1px dashed gray; text-align: center; background: #eee8aa; margin-right: 5px; cursor: pointer; border-radius: 4px; padding: 2px; margin-bottom: 5px; }
    </style>
    <div class="demo_main">
        <fieldset class="demo_title">
            数据表数据 <span style="color: green">（请从左侧导航树上右键弹出菜单以进行操作）</span>
        </fieldset>
        <fieldset class="demo_content">
            <legend>查询语句： </legend>
            <textarea id="input"></textarea>
            <p style="margin: 0; padding: 8px 0 0 0;">
                <%=Html%></p>
        </fieldset>
        <fieldset class="demo_content">
            <legend>操作选项</legend>
            <input type="button" id="btnExcute" value="执行" /><span class="lblstatus"></span>
        </fieldset>
        <fieldset class="demo_content output">
            <legend>查询结果：</legend>
            <div class="result">
            </div>
        </fieldset>
    </div>
    <script type="text/javascript">
        //====================================在文本框指定位置插入值=======================================
        (function ($) {
            $.fn.extend({
                insertAtCaret: function (myValue) {
                    var $t = $(this)[0];
                    if (document.selection) {
                        this.focus();
                        var sel = document.selection.createRange();
                        sel.text = myValue;
                        this.focus();
                    } else if ($t.selectionStart || $t.selectionStart == '0') {
                        var startPos = $t.selectionStart;
                        var endPos = $t.selectionEnd;
                        var scrollTop = $t.scrollTop;
                        $t.value = $t.value.substring(0, startPos) + myValue + $t.value.substring(endPos, $t.value.length);
                        this.focus();
                        $t.selectionStart = startPos + myValue.length;
                        $t.selectionEnd = startPos + myValue.length;
                        $t.scrollTop = scrollTop;
                    } else {
                        this.value += myValue;
                        this.focus();
                    }
                }
            });
        })(jQuery);
        //==================================================================================
        var action = getQueryString("action");
        var dbId = getQueryString("dbId");
        var table = getQueryString("tableName");
        var sql = "";
        $(function () {
            //执行按钮
            $("#btnExcute").click(function () {
                $(".lblstatus").html("<span style='color:green'>请求处理中,请稍候...</span>");
                $("#btnExcute").attr({ "disabled": "disabled" });

                sql = $("#input").val();
                if (sql.length > 0 & dbId > 0) {
                    $.whir.ajax('DataBaseHandler.GetData', {
                        params: {
                            sql: escape(sql),
                            tableName: table,
                            dbId: dbId
                        },
                        success: function (response) {
                            var data = eval(response)[0];
                            var status = data.status;
                            var result = data.result;
                            switch (status.toLowerCase()) {
                                case "true":
                                    var maxWidth = $(parent.frames["right"]).width() - 65;
                                    $(".result").html(result);
                                    $(".result").css("width", maxWidth + "px");
                                    $(".result").css("overflow", "scroll");
                                    break;
                                default:
                                    AlertErrorMsg(result);
                                    break;
                            }

                            $(".lblstatus").html("");
                            $("#btnExcute").removeAttr("disabled");
                        }
                    });
                } else {
                    $(".lblstatus").html("");
                    $("#btnExcute").removeAttr("disabled");
                    AlertErrorMsg("请输入查询脚本并连接数据库！");
                }

            });
            switch (action) {
                case "top200":
                    sql = "SELECT TOP 200 * FROM " + table;
                    $("#input").val(sql);
                    $("#btnExcute").trigger("click");
                    break;
                case "customQuery":
                    sql = "SELECT * FROM " + table;
                    $("#input").val(sql);
                    break;
            }

            //点击可用字段
            $(".fieldselect").click(function () {
                var field = $(this).text();
                $("#input").insertAtCaret(field);

            });
        });

    </script>
    </form>
</body>
</html>
