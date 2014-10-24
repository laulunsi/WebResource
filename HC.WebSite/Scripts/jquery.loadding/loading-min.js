if (!window.ol) {
    window.ol = { };
}
(function() {
    var jq = jQuery;
    ol.loading = function(config) {
        var options = {
            id: null,
            loadingClass: null,
            zIndex: 800
        };
        this.init = function() {
            config = jq.extend({ }, options, config);
            this.container = jq("#" + config.id);
            var position = this.container.css("position");
            //var outerWidth = this.container.outerWidth();
            //outerWidth = outerWidth > 0 ? outerWidth : "";
            position = position == "absolute" ? "absolute" : "relative";
            var mask = jq("<div id='loading'></div>").css({
                //position: position,
                top: this.container.css("top"),
                left: this.container.css("left"),
                right: this.container.css("right"),
                bottom: this.container.css("bottom") 
                //width:outerWidth
            });

            //用loading div 包裹元素
            if (this.container.parent().attr("id") != "loading") {
                this.container.css({
                    position: "relative",
                    width: "100%",
                    top: null,
                    right: null,
                    left: null,
                    bottom: null
                }).wrap(mask);
            }

            //遮罩层
            this.loadingMask = jq('<div class="ol_loading_mask"></div>');
            this.loadingMask.css({
                zIndex: config.zIndex
            });

            //Loading图
            this.loadingImg = jq('<div class="ol_loading"></div>').css("z-index", config.zIndex + 1);
            if (!config.loadingClass) {
                this.loadingImg.addClass(config.loadingClass);
                this.loadingMask.addClass(config.loadingClass + "_mask");
            }
            if (($(".ol_loading_mask").length == 0 & $(".ol_loading").length == 0)) {
                this.container.parent().append(this.loadingMask).append(this.loadingImg);
            }
        };

        //显示
        this.show = function() {
            if (/msie/.test(navigator.userAgent.toLowerCase()) && /6.0/.test(navigator.userAgent)) {
                this.loadingMask.css({
                    width: this.container.outerWidth(),
                    height: this.container.outerHeight()
                });
            }
            $(".ol_loading_mask").show();
            $(".ol_loading").show();
        };

        //隐藏
        this.hide = function() {
            $(".ol_loading_mask").css("display", "none");
            $(".ol_loading").fadeOut(0);
        };
        //初始化
        this.init();
    };
})();