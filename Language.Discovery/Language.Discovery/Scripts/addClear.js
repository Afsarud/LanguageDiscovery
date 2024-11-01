﻿// Author: Stephen Korecky
// Website: http://stephenkorecky.com
// Plugin Website: http://github.com/skorecky/Add-Clear

; (function ($, window, document, undefined) {

    // Create the defaults once
    var pluginName = "addClear",
		defaults = {
		    closeSymbol: "&#10006;",
		    color: "#CCC",
		    top: 5,
		    right: 50,
		    returnFocus: true,
		    showOnLoad: false,
		    onClear: null,
		    hideOnBlur: false
		};

    // The actual plugin constructor
    function Plugin(element, options) {
        this.element = element;

        this.options = $.extend({}, defaults, options);

        this._defaults = defaults;
        this._name = pluginName;

        this.init();
    }

    Plugin.prototype = {

        init: function () {
            var $this = $(this.element),
					me = this,
					 options = this.options;

            $this.wrap("<span style='position:relative;' class='add-clear-span'></span>");
            $this.after($("<a href='#clear' style='display: none;color:red;'>" + "<img src='/Images/x.png' title='' class='smcsc_search_x' style='width:16px;height:16px;position:absolute;top:17px;right:" + options.right + "px;'/>" + "</a>"));
            $this.next().css({
                display: 'none'
            }, this);

            if ($this.val().length >= 1 && options.showOnLoad === true) {
                $this.siblings("a[href='#clear']").show();
            }

            $this.focus(function () {
                if ($(this).val().length >= 1) {
                    $(this).siblings("a[href='#clear']").show();
                }
            });

            $this.blur(function () {
                var self = this;

                if (options.hideOnBlur) {
                    setTimeout(function () {
                        $(self).siblings("a[href='#clear']").hide();
                    }, 50);
                }
            });

            $this.keyup(function () {
                if ($(this).val().length >= 1) {
                    $(this).siblings("a[href='#clear']").show();
                } else {
                    $(this).siblings("a[href='#clear']").hide();
                }
            });

            $("a[href='#clear']").click(function (e) {
                $(this).siblings(me.element).val("");
                $(this).hide();
                if (options.returnFocus === true) {
                    $(this).siblings(me.element).focus();
                }
                if (options.onClear) {
                    options.onClear($(this).siblings("input"));
                }
                e.preventDefault();
            });
        }

    };

    $.fn[pluginName] = function (options) {
        return this.each(function () {
            if (!$.data(this, "plugin_" + pluginName)) {
                $.data(this, "plugin_" + pluginName,
					new Plugin(this, options));
            }
        });
    };

})(jQuery, window, document);