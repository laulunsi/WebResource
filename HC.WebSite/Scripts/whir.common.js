//--------------------------------------------------------------------------------
// 文件描述：js公共方法封装
// 文件作者：张清山
// 创建日期：2013-12-23 14:38:06
// 修改记录：
//--------------------------------------------------------------------------------


/*************
01. js字典 装用Dictionary.js替换
*************/

/*************
02. 字符串方法封装
*************/
String.prototype.trim = function () { return this.replace(/^\s+|\s+$/g, ""); };
String.prototype.ltrim = function () { return this.replace(/^\s+/g, ""); };
String.prototype.rtrim = function () { return this.replace(/\s+$/g, ""); };
String.prototype.ReplaceAll = function (oldChar, newChar) {
    var temp = this;
    for (var i = 0; i < oldChar.length; i++) {
        temp = temp.replace(oldChar[i], newChar[i]);
    };
    return temp;
};
String.prototype.endWith = function (suffix) {
    return this.indexOf(suffix, this.length - suffix.length) !== -1;
};
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

/*************
04. 通用系统对话框 
*************/
/** 
* 成功提示
* @msg	{String}	提示内容
* @time   {Number}    显示时间 (默认1.5秒) 
* @callback   {Function}  提示关闭时执行的回调函数
*/
function AlertSuccessMsg(msg, time, callback) {
    if (time == undefined) time = 1.5;
    if (frameElement == null || !frameElement.api || frameElement.api == undefined) {
        $.dialog.tips(msg, time, 'success.gif', callback);
    } else {
        //弹出的页面再弹出
        frameElement.api.opener.$.dialog.tips(msg, time, 'success.gif', callback);
    }
}
/**
* 失败提示
* @msg	{String}	提示内容
* @time   {Number}    显示时间 (默认1.5秒) 
* @callback   {Function}  提示关闭时执行的回调函数
*/
function AlertErrorMsg(msg, time, callback) {
    if (time == undefined) time = 1.5;
    if (frameElement == null || !frameElement.api || frameElement.api == undefined) {
        $.dialog.tips(msg, time, 'alert.gif', callback);
    } else {
        //弹出的页面再弹出
        frameElement.api.opener.$.dialog.tips(msg, time, 'alert.gif', callback);
    }
}

/**
* 确认提示
* @msg	{String}	提示内容
* @okCallback   {Function}    确认时回调函数
* @cancleCallback   {Function}  取消时回调函数
*/
function ConfirmDialog(msg, okCallback, cancleCallback) {
    if (frameElement == null || !frameElement.api || frameElement.api == undefined) {
        $.dialog.confirm(msg, okCallback, cancleCallback);
    } else {
        //弹出的页面再弹出
        frameElement.api.opener.$.dialog.confirm(msg, okCallback, cancleCallback);
    }
}

/*************
05. Cookie读写 
*************/
//取得cookie
function getCookie(name) {
    if (document.cookie.length > 0) {
        var start = document.cookie.indexOf(name + "=");
        if (start != -1) {
            start = start + name.length + 1;
            var end = document.cookie.indexOf(";", start);
            if (end == -1) end = document.cookie.length;
            return unescape(document.cookie.substring(start, end));
        }
    }
    return "";
}
//设置cookie
function setCookie(name, value, expiredays) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + expiredays);
    document.cookie = name + "=" + escape(value) + ((expiredays == null) ? "" : ";expires=" + exdate.toGMTString());
}

//页面添加遮罩
function mask(show) {
    if (show) {
        var loadMask = $("<div class='loadMask'></div>");
        loadMask.css({
            "position": "absolute",
            "zIndex": "1000",
            "top": "0px",
            "left": "0px",
            "height": $(window).height() + "px",
            "width": $(window).width() + "px",
            "border": "1px solid white",
            "background": "white",
            "opacity": "0.5"
        });
        if ($(".loadMask").length == 0) {
            $("body").append(loadMask);
        } else {
            $(".loadMask").show();
        }
    } else {
        $(".loadMask").hide();
    }
}
       

       