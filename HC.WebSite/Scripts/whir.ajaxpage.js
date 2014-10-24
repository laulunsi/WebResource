//--------------------------------------------------------------------------------
// 文件描述：整站列表页面Ajax加载封装，使用本插件时，请确保页面已经引用以下插件:jquery-1.7.2.min.js，whir.ajax.js，jquery.pagination.js，loading-min.js
// 文件作者：张清山
// 创建日期：2013-12-13 11:17:06
// 修改记录：
//--------------------------------------------------------------------------------

(function ($) {

    var isFirstLoad = false; //用于防止因初始化分页而再次查询第一页信息

    //默认配置
    var defaults = {
        pageIndex: 1, //当前页码
        pageSize: 10, //分页大小
        handler: "UserHandler.GetUserList", //处理程序
        tableHeaderTemplate: "userHeaderTemplate", //表头模板
        tableDataTemplate: "userDataTemplate", //表数据模板
        tableNoDataTemplate: "userNoDataTemplate", //无数据模板
        table: "#userTable", //表格Dom元素，可以不传
        pager: "#pager", //分页Dom元素
        params: {}, //自定义查询参数
        callback: null
    };

    $.fn.ajaxPage = function (options) {
        options = $.extend(defaults, options);
        this.each(function () {
            var table = $(this);
            var pager = options.pager;
            options.table = table.attr("id");

            //初始化页码
            var currentPageIndex = 1;
            if (window.location.href.match(/page=\d+/g)) {
                currentPageIndex = window.location.href.match(/page=\d+/g)[0].replace("page=", "");
            }
            options.pageIndex = currentPageIndex;

            isFirstLoad = true; //用于防止因初始化分页而再次查询第一页信息

            //遮罩Loading
            var loading = new ol.loading({ id: $(this).attr("id") });
            loading.show();

            //表头模板
            var head = $("#" + options.tableHeaderTemplate).render();
            var noData = $("#" + options.tableNoDataTemplate).render();

            //自定义查询参数
            var params = options.params;
            var pageParams = { pageIndex: options.pageIndex, pageSize: options.pageSize };
            params = $.extend(params, pageParams);

            $.whir.ajax(options.handler, {
                params: params,
                success: function (rsp) {
                    var result = eval(rsp)[0];
                    if (Boolean(result.status)) {
                        if (result.body.length > 0) {
                            var list = eval(result.body);
                            var total = parseInt(result.total);
                            if (list) {
                                if (list.length > 0 && total > 0) {

                                    //加载第一页数据 
                                    if (table.is("table")) {
                                        table.html(head + "<tbody>" + $("#" + options.tableDataTemplate).render(list) + "</tbody>");
                                    } else if (table.is("ul")) {
                                        table.html(head + $("#" + options.tableDataTemplate).render(list) + "<div class='clear'></div>");
                                    }

                                    //回调函数
                                    if (options.callback != null) {
                                        options.callback(result);
                                    }
                                    //扔掉遮罩
                                    loading.hide();

                                    //分页
                                    var option = initPagerOptions(currentPageIndex - 1);
                                    $(pager).show();
                                    $(pager).pagination(total, option);

                                } else {
                                    table.html(head + noData);
                                    $(pager).hide();
                                    loading.hide();
                                }
                            }
                        } else {
                            table.html(head + noData);
                            loading.hide();
                        }
                    } else {
                        table.html(head + noData);
                        loading.hide();
                    }
                },
                err: function (msg) {
                    alert("err:" + msg);
                }
            });

        });


        //初始化分页参数

        function initPagerOptions(currentPage) {
            var option = { callback: pageCallback }; //回调函数
            option.items_per_page = options.pageSize; //每页记录的条数
            option.num_display_entries = 6; //显示的可见的分页数
            option.num_edge_entries = 2; //分页链接在末尾显示的个数
            option.prev_text = '上一页';
            option.next_text = '下一页';
            option.current_page = currentPage;
            return option;
        }

        //分页回调函数
        var loading;

        function pageCallback(index) {
            if (!isFirstLoad) {

                //当前页索引
                options.pageIndex = parseInt(index + 1);

                //表格对象
                var table = $('#' + options.table);

                //遮罩Loading
                loading = new ol.loading({ id: $(table).attr('id') });
                loading.show();

                //表头模板 
                var head = $("#" + options.tableHeaderTemplate).render();
                var noData = $("#" + options.tableNoDataTemplate).render();

                //自定义查询参数
                var params = options.params;
                var pageParams = { pageIndex: options.pageIndex, pageSize: options.pageSize };
                params = $.extend(params, pageParams);

                $.whir.ajax(options.handler, {
                    params: params,
                    success: function (rsp) {
                        var result = eval(rsp)[0];
                        if (Boolean(result.status)) {
                            if (result.body.length > 0) {
                                var list = eval(result.body);
                                var total = parseInt(result.total);
                                if (list) {
                                    if (list.length > 0 && total > 0) { 
                                        //加载第一页数据 
                                        if (table.is("table")) {
                                            table.html(head + "<tbody>" + $("#" + options.tableDataTemplate).render(list) + "</tbody>");
                                        } else if (table.is("ul")) {
                                            table.html(head + $("#" + options.tableDataTemplate).render(list) + "<div class='clear'></div>");
                                        }
                                        //回调函数
                                        if (options.callback != null) {
                                            options.callback(result);
                                        }
                                        //扔掉遮罩
                                        loading.hide();

                                    } else {
                                        $(table).find("tbody").html(noData);
                                        loading.hide();
                                    }
                                }
                            } else {
                                $(table).find("tbody").html(noData);
                                loading.hide();
                            }
                        } else {
                            $(table).find("tbody").html(noData);
                            loading.hide();
                        }
                    },
                    err: function (msg) {
                        alert("err:" + msg);
                    }
                });
                //处理Url
                var url = document.URL;
                if (url.match(/page=\d+/g)) {
                    url = url.replace(/page=\d+/g, "page=" + (index + 1));
                } else {
                    url += "#page=" + (index + 1);
                }
                history.pushState({}, document.title, url); //修改页面Url但不刷新页面，参考：http://www.welefen.com/use-ajax-and-pushstate.html

            } else {
                isFirstLoad = false;
            }
            return false;
        }

    };

    //模板引擎辅助方法
    $.views.helpers({
        formatDateTime: function (val, format) {
            var date = new Date(val);
            var year = date.getFullYear();
            var month = date.getMonth();
            var day = date.getDate();
            var hour = date.getHours();
            var min = date.getMinutes();
            var sec = date.getSeconds();
            month = month < 10 ? "0" + month : month;
            day = day < 10 ? "0" + day : day;
            hour = hour < 10 ? "0" + hour : hour;
            min = min < 10 ? "0" + min : min;
            sec = sec < 10 ? "0" + sec : sec;

            switch (format.toLowerCase()) {
                case "yyyy-mm-dd":
                    return year + "-" + month + "-" + day;
                case "yyyy-mm-dd hh:mm:ss":
                    return year + "-" + month + "-" + day + " " + hour + ":" + min + ":" + sec;
                case "yyyy/mm/dd":
                    return year + "/" + month + "/" + day;
            }
            return year + "-" + month + "-" + day;
        },
        toLower: function (val) {
            if (val) {
                return val.toString().toLowerCase();
            }
            return "";
        },
        shortTitle: function (val, length) {
            length = length == undefined ? 15 : length;
            if (val != undefined & length > 0) {
                if (val.length > length) {
                    return val.toString().substring(0, length) + "...";
                }
                return val;
            }
            return "";
        }
    }
);
})(jQuery);

//元素加载数据
//使用方法
//  $("#html").loadData({
//                handler:"BlockHandler.ReadFile",//处理程序
//                params: { blockName: blockName, fileName: "html.html" } //自定义参数
//            });
//  默认会将取到的数据放到Dom元素里 
//  $("#html").loadData({
//                handler:"BlockHandler.ReadFile",//处理程序
//                params: { blockName: blockName, fileName: "html.html" }, //自定义参数
//                callback:function(elem,data){}
//            });
//如果需要对取到的数据进行处理，还可以传递一个回调函数进去，回调函数参数：dom元素，data数据
(function ($) {

    //默认配置
    var defaults = {
        handler: "UserHandler.GetUserList", //处理程序
        params: {}, //自定义查询参数
        callback: null
    };

    $.fn.loadData = function (options) {
        options = $.extend(options, options);
        this.each(function () {
            var elem = $(this);
            $.whir.ajax(options.handler, {
                params: options.params,
                success: function (response) {
                    var result = eval(response)[0];
                    if (Boolean(result.status)) {
                        setData(options, elem, result.body);
                    } else {
                        setData(options, elem, "请求失败，请勿再试");
                    }
                },
                err: function (msg) {
                    setData(options, elem, "异常：" + msg);
                }
            });

        });
    };

    function setData(options, elem, data) {
        if (options.callback != null) {
            options.callback(elem, data);
        } else {
            switch (elem.get(0).tagName.toLocaleLowerCase()) {
                case "p":
                case "div":
                case "span":
                    elem.html(data);
                    break;
                case "input":
                case "textarea":
                    elem.val(data);
                    break;
                default:
                    elem.html(data);
                    break;
            }
        }
    }
})(jQuery);