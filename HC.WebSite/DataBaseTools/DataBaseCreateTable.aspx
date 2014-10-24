<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataBaseCreateTable.aspx.cs"
    Inherits="HC.WebSite.DataBaseTools.DataBaseCreateTable" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <style type="text/css">
        .td_Item { text-align: center; background-color: #D3D8E0; width: 20%; }
        .td_table { text-align: right; }
        #content { border-top: 0 !important; }
        #content .td_Item { background-color: white !important; }
        td input { border: 1px solid gray; border-top: 0; border-left: 0; border-right: 0; margin-bottom: 5px; }
        .td_Item span { cursor: pointer; }
    </style>
    <div class="demo_main">
        <fieldset class="demo_title">
            快速建表
        </fieldset>
        <fieldset class="demo_content">
            <table class="tableFields">
                <tr class="td_title">
                    <td class='td_Item'>
                        表信息
                    </td>
                    <td colspan="5">
                        &nbsp;&nbsp;表名
                        <input id="TxtTableName" onblur="checkTableName(this)" type="text" />
                        备注
                        <input id="TxtTableNote" onblur="checkTableNote(this)" type="text" />
                    </td>
                </tr>
                <tr class="td_title">
                    <td class='td_Item'>
                        序号
                    </td>
                    <td class='td_Item'>
                        字段名称
                    </td>
                    <td class='td_Item'>
                        类型
                    </td>
                    <td class='td_Item'>
                        描述
                    </td>
                    <td class='td_Item'>
                        操作 <a href="#" class="AddNewField">添加</a>
                    </td>
                </tr>
            </table>
            <table id="content">
            </table>
            <br />
            <input type="button" id="btnSubmit" value="生成脚本" />
        </fieldset>
        <fieldset class="demo_content">
            <legend>脚本</legend>
            <textarea id="output"></textarea>
        </fieldset>
    </div>
    <script type="text/javascript">
        $(function () {

            $(".AddNewField").trigger("click");

            $("#btnSubmit").click(function () {
                var tableName = $("#TxtTableName").val();
                var tableNote = $("#TxtTableNote").val();
                if (tableName.length > 0) {
                    tableNote = tableNote.length == 0 ? tableName : tableNote;
                    var fieldXml = SaveData();
                    var fieldCount = $(fieldXml).find("item").length;
                    if (fieldCount > 0) {
                        var sql = "CREATE TABLE [dbo].[" + tableName + "](  \r\n";
                        $(fieldXml).find("item").each(function () {
                            var fieldName = $(this).find("fieldName").text();
                            var fieldType = $(this).find("fieldType").text();
                            if (fieldName.length > 0) {
                                sql += "[" + fieldName + "] " + fieldType + " NULL,\r\n";
                            }

                        });
                        sql = sql.substring(0, sql.lastIndexOf(',')) + "\r\n";
                        sql += ")\r\n";
                        $(fieldXml).find("item").each(function () {
                            var fieldName = $(this).find("fieldName").text();
                            var fieldNote = $(this).find("fieldNote").text();
                            if (fieldName.length > 0) {
                                sql += "EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'" + fieldNote + "', @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'" + tableName + "', @level2type=N'COLUMN',@level2name=N'" + fieldName + "'\r\n";
                                sql += "GO\r\n";
                            }
                        });
                        sql += "EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'" + tableNote + "', @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'" + tableName + "'\r\n";
                        $("#output").val(sql);
                    } else {
                        AlertErrorMsg("未添加任何字段,请点击添加按钮！");
                    }
                } else {
                    $("#TxtTableName").focus();
                    AlertErrorMsg("请填写表名称！");
                }
            });
        });
        //保存数据
        function SaveData() {
            var data = "<root>";
            $('#content tr').each(function () {
                var fieldName = $(this).find("td:eq(1)").find("input").val();
                var fieldType = $(this).find("td:eq(2)").find("select").val();
                var fieldNote = $(this).find("td:eq(3)").find("input").val();
                data += "<item>";
                data += "   <fieldName>" + fieldName + "</fieldName>";
                data += "   <fieldType>" + fieldType + "</fieldType>";
                data += "   <fieldNote>" + fieldNote + "</fieldNote>";
                data += "</item>";
            });
            data += "</root>";
            return (data);
        }

        function checkTableName(index) {
            var text = $(index).val();
            $(index).attr("value", text);
            if (text.length > 0) {
                var $tableNote = $(index).next();
                if ($tableNote.val().length == 0) {
                    translate(text, "en", "", $tableNote);
                }
            }
        }

        function checkTableNote(index) {
            var text = $(index).val();
            $(index).attr("value", text);
            if (text.length > 0) {
                var $table = $(index).prev();
                if ($table.val().length == 0) {
                    translate(text, "zh-cn", "", $table);
                }
            }
        }

        function checkFieldName(index) {
            var text = $(index).val();
            $(index).attr("value", text);
            if (text.length > 0) {
                var $note = $(index).parent().parent().find("td:eq(3)").find("input");
                if ($note.val().length == 0) {
                    translate(text, "en", "", $note);
                }
            }
        }
        function checkFieldNote(index) {
            var text = $(index).val();
            $(index).attr("value", text);
            if (text.length > 0) {
                var $name = $(index).parent().parent().find("td:eq(1)").find("input");
                if ($name.val().length == 0) {
                    translate(text, "zh-cn", "", $name);
                }
            }
        }
        function translate(input, from, type, dom) {
            dom.val("...");
            $.whir.ajax('DataBaseHandler.Translater', {
                params: {
                    input: input,
                    form: from,
                    type: type
                },
                success: function (response) {
                    var data = eval(response)[0];
                    var status = data.status;
                    var result = data.result;
                    switch (status.toLowerCase()) {
                        case "true":
                            dom.val(result);
                            dom.attr("value", result);
                            break;
                    }
                }
            });
        }

        var currentStep = 0;
        var max_line_num = 0;

        //添加新记录
        function add_line() {
            max_line_num = $("#content tr:last-child").children("td").html();
            if (max_line_num == null) {
                max_line_num = 1;
            }
            else {
                max_line_num = parseInt(max_line_num);
                max_line_num += 1;
            }

            var select = "";
            select += "<select id='SelectFieldType_" + max_line_num + "' name='FieldType_" + max_line_num + "' class='FieldType'>";
            select += "  <option>[Int]</option>";
            select += "  <option>[datetime]</option>";
            select += "  <option>[nvarchar](200)</option>";
            select += "  <option>[nvarchar](Max)</option>";
            select += "  <option>[ntext]</option>";
            select += "  <option>decimal(18,2)</option>";
            select += "  <option>[float]</option>";
            select += "</select>";

            $('#content').append(
                "<tr id='line" + max_line_num + "'>" +
                    "<td class='td_Item'>" + max_line_num + "</td>" +
                    "<td class='td_Item'><input type='text' class='fieldItemName' onblur='checkFieldName(this)' onkeydown=''></input></td>" +
                    "<td class='td_Item'>" + select + "</td>" +
                    "<td class='td_Item'><input type='text' class='fieldItemNote' onblur='checkFieldNote(this)'></td>" +
                    "<td class='td_Item'>" +
                    "<span onclick='up_exchange_line(this);'>上移</span> " +
                    "<span onclick='down_exchange_line(this);'>下移</span> " +
                    "<span onclick='remove_line(this);'>删除</span> " +
                    "</td>" +
                    "</tr>");
            $("#line" + max_line_num).find("td:eq(3)").find("input").focus();
            var $fieldItemNote = jQuery('.fieldItemNote');
            $fieldItemNote.unbind("keydown");
            $fieldItemNote.bind('keydown', function (e) {
                var key = e.which;
                if (key == 13) {
                    e.preventDefault();
                    $('.AddNewField').trigger('click');
                }
            });

        }
        //删除选择记录
        function remove_line(index) {
            if (index != null) {
                currentStep = $(index).parent().parent().find("td:first-child").html();
            }
            if (currentStep == 0) {
                alert('请选择一项!');
                return false;
            }
            //if (confirm("确定要删除该记录吗？")) {
            $("#content tr").each(function () {
                var seq = parseInt($(this).children("td").html());
                if (seq == currentStep) { $(this).remove(); }
                if (seq > currentStep) { $(this).children("td").each(function (i) { if (i == 0) $(this).html(seq - 1); }); }
            });
            //}
        }
        //上移
        function up_exchange_line(index) {
            if (index != null) {
                currentStep = $(index).parent().parent().find("td:first-child").html();
            }
            if (currentStep == 0) {
                alert('请选择一项!');
                return false;
            }
            if (currentStep <= 1) {
                alert('已经是最顶项了!');
                return false;
            }
            var upStep = currentStep - 1;
            //修改序号
            $('#line' + upStep + " td:first-child").html(currentStep);
            $('#line' + currentStep + " td:first-child").html(upStep);
            //取得两行的内容
            var upContent = $('#line' + upStep).html();
            var currentContent = $('#line' + currentStep).html();
            $('#line' + upStep).html(currentContent);
            //交换当前行与上一行内容
            $('#line' + currentStep).html(upContent);
            $('#content tr').each(function () { $(this).css("background-color", "#ffffff"); });
            $('#line' + upStep).css("background-color", "yellow");
            event.stopPropagation(); //阻止事件冒泡
        }
        //下移
        function down_exchange_line(index) {
            if (index != null) {
                currentStep = $(index).parent().parent().find("td:first-child").html();
            }
            if (currentStep == 0) {
                alert('请选择一项!');
                return false;
            }
            if (currentStep >= max_line_num) {
                alert('已经是最后一项了!');
                return false;
            }
            var nextStep = parseInt(currentStep) + 1;
            //修改序号
            $('#line' + nextStep + " td:first-child").html(currentStep);
            $('#line' + currentStep + " td:first-child").html(nextStep);
            //取得两行的内容
            var nextContent = $('#line' + nextStep).html();
            var currentContent = $('#line' + currentStep).html();
            //交换当前行与上一行内容
            $('#line' + nextStep).html(currentContent);
            $('#line' + currentStep).html(nextContent);
            $('#content tr').each(function () { $(this).css("background-color", "#ffffff"); });
            $('#line' + nextStep).css("background-color", "yellow");
            event.stopPropagation(); //阻止事件冒泡
        }
        $(".AddNewField").click(function () {
            add_line();
            $("#content tr").eq(0).find("td").each(function () {
                $(this).css("border-top", "0px");
            });
        });
    </script>
    </form>
</body>
</html>
