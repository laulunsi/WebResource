
$(function () {

    //顶部一级菜单切换
    $("#firstMenu li").click(function () {
        //设置二级菜单
        var id = $(this).attr("id");
        $("#secondMenu div").hide();
        $("#sub_" + id).show();

        //设置选中样式
        $("#firstMenu li").removeClass("currentMenu");
        $(this).addClass("currentMenu");
    });
    $("#firstMenu li").eq(0).trigger("click");
    onload();

});

//响应菜单点击事件
function showUrl(fileNameLeft, fileNameRight) {
    var temp;
    if (fileNameLeft != "") {
        var checkLeftUrl = CheckCurrentLeftUrl(fileNameLeft);
        if (checkLeftUrl == "false") {
            temp = document.getElementById("left");
            temp.src = fileNameLeft + GetUrlParm(fileNameLeft);
            temp.contentWindow.window.name = "left";
            frames["left"] = temp.contentWindow.window;
        }
    }
    if (fileNameRight != "") {
        temp = document.getElementById("right");
        temp.src = fileNameRight + GetUrlParm(fileNameRight);
        temp.contentWindow.window.name = "right";
        frames["right"] = temp.contentWindow.window;
    }
    //window.onresize();
}
//Url附加随机数
function GetUrlParm(url) {
    var urlparm = "?";
    if (url.indexOf('?') >= 0) {
        urlparm = "&";
    }
    urlparm = urlparm + "t=" + GetRandomNum();
    return urlparm;
}
function GetRandomNum() {
    var range = 1000;
    var rand = Math.random();
    return (Math.round(rand * range));
}
function CheckCurrentLeftUrl(leftUrl) {
    var src = document.getElementById("left").src;
    var regex = /\s*[\?&]{1,1}t=[0-9]{1,}$/;
    var currentLeftUrl = src.replace(regex, '');
    if (currentLeftUrl.lastIndexOf(leftUrl) >= 0) {
        if (currentLeftUrl.lastIndexOf(leftUrl) == (currentLeftUrl.length - leftUrl.length)) {
            return "true";
        }
    }
    return "false";
}
//窗体大小自适应
function onload() {
    var topHeight = 86;
    var winHeight = $(window).height();
    var winWidth = $(window).width();
    var leftWidth = $("#left").width();  
    var rightWidth = winWidth - leftWidth - 10;
    var rightHeight = (winHeight - topHeight)-20;

    $("#right").width(rightWidth);
    $("#right").height(rightHeight);
    $("#left").height(rightHeight);
}
window.onresize = onload;


/*************
03. 取得Url查询参数
*************/
function getQueryString(name) {
    if (location.href.indexOf("?") == -1 || location.href.toLocaleLowerCase().indexOf(name.toLocaleLowerCase() + '=') == -1) {
        return '';
    }
    var qs = location.href.substring(location.href.indexOf("?") + 1);
    var parms = qs.split("&");
    var pos, paraName, paraValue;
    for (var i = 0; i < parms.length; i++) {
        pos = parms[i].indexOf('=');
        if (pos == -1) {
            continue;
        }
        paraName = parms[i].substring(0, pos);
        paraValue = parms[i].substring(pos + 1);
        if (paraName.toLocaleLowerCase() == name.toLocaleLowerCase()) {
            return decodeURIComponent(paraValue.replace(/\+/g, " "));
        }
    }
    return '';
}
 
       