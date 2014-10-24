<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CodeSearch.aspx.cs" Inherits="HC.WebSite.CodeView.CodeSearch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="padding: 2px 8px 0px 8px; margin: 0px; text-decoration: none; line-height: 150%;">
    <link href="<%=BasePath %>Scripts/jquery.loadding/loading.css" rel="stylesheet" type="text/css" />
    <link href="<%=BasePath %>Scripts/jquery.pagination/pagination.css" rel="stylesheet"
        type="text/css" />
    <script src="<%=BasePath %>Scripts/jquery.jsrender/jsrender.js" type="text/javascript"></script>
    <script src="<%=BasePath %>Scripts/jquery.pagination/jquery.pagination.js" type="text/javascript"></script>
    <script src="<%=BasePath %>Scripts/jquery.loadding/jquery.bgiframe.min.js" type="text/javascript"></script>
    <script src="<%=BasePath %>Scripts/jquery.loadding/loading-min.js" type="text/javascript"></script>
    <script src="<%=BasePath %>Scripts/whir.ajaxpage.js" type="text/javascript"></script>
    <style type="text/css">
        #templateul { width: 98%; margin-left: -40px; }
        #templateul li { overflow: hidden; padding: 5px; border-bottom: 1px dashed lightgray; }
        #templateul li:hover { padding: 5px; border-bottom: 1px dashed lightgray; background-color: lavender; }
        .file_title { font-family: -webkit-pictograph; font-weight: bold; }
        .file_content { color: gray; }
        a:link { color: #000000; text-decoration: none; }
        a:visited { color: #000000; text-decoration: none; }
        a:hover { color: #000000; text-decoration: none; }
        a:active { color: #000000; text-decoration: none; }
        #txtKeyword { font-family: 微软雅黑; font-weight: bold; width: 400px; padding: 5px; border: 1px solid #d8d8d8; }
    </style>
    <form id="form1" runat="server">
    <div class="right_main">
        <fieldset class="demo_title">
            代码搜索:
            <input type="text" class="text" id="txtKeyword" placeholder="请输入查询关键字" value="Framework" />
            <input type="button" id="btnSearch" value="搜索" class="btn" />
            <input type="button" id="btnCreateIndex" value="创建索引" class="btn" />
        </fieldset>
        <fieldset class="demo_content">
            <ul id="templateul">
            </ul>
            <div id="pager" class="pagination Pages">
            </div>
        </fieldset>
    </div>
    <%----------------------------------------------数据加载脚本-------------------------------------------------%>
    <!--表头布局 -->
    <script id="thumbHeaderTemplate" type="text/x-jsrender">
    </script>
    <!--数据布局-->
    <script id="thumbDataTemplate" type="text/x-jsrender">
        <li> 
            <div class="file_title"><a href="CodeView.aspx?path={{>FullPath}}">{{>Title}}</a></div>
            <div class="file_content">{{:BodyPreview}}</div>
        </li> 
    </script>
    <!--无数据布局-->
    <script id="thumbNoDataTemplate" type="text/x-jsrender">
        <li>
		      暂无数据            
	    </li>
    </script>
    <script type="text/javascript">

        //列表页配置
        var options = {
            pageIndex: 1, //当前页码
            pageSize: 10, //分页大小
            handler: "CodeViewHandler.GetData", //处理程序
            tableHeaderTemplate: "thumbHeaderTemplate", //表头布局
            tableDataTemplate: "thumbDataTemplate", //表数据布局
            tableNoDataTemplate: "thumbNoDataTemplate", //无数据布局
            table: "#templateul", //表格Dom元素，可以不传
            pager: "#pager", //分页Dom元素
            params: {}, //自定义查询参数
            callback: function (result) {
                //$("#pager").append("<span>耗时：" + result.time+"</span>");
            }
        };

        $(function () {

            //搜索按钮
            $("#btnSearch").click(function () {
                doSearch();
            });
            $("#btnCreateIndex").click(function () {
                $.whir.ajax('CodeViewHandler.CreateLuceneNetIndex', {
                    success: function (response) {
                        var result = eval(response)[0];
                        if (Boolean(result.status)) {
                            AlertSuccessMsg(result.body);
                        }
                    },
                    err: function (msg) {
                        AlertErrorMsg("异常：" + msg);
                    }
                });
            });


            //回车立即搜索
            $("#txtKeyword").bind('keydown', function (e) {
                var key = e.which;
                if (key == 13) {
                    e.preventDefault();
                    doSearch();
                }
            });

            //执行搜索
            function doSearch() {
                options.params = { q: $("#txtKeyword").val() };
                $("#templateul").ajaxPage(options);
                $("#templateul").show();
            }

            //初始化搜索
            if (getQueryString("q") != "") {
                $("#txtKeyword").val(getQueryString("q"));
                doSearch();
            } else {
                if ($("#txtKeyword").val() != "") {
                    doSearch();
                }
            }
        });

    </script>
    </form>
</body>
</html>
