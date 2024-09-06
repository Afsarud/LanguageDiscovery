(function ($, undefined) {
    $.fn.clearable = function () {
        var $this = this;
        $this.wrap('<div class="clear-holder" />');
        var helper = $('<span class="clear-helper">&times;</span>');
        $this.parent().append(helper);
        $this.parent().on('keyup', function () {
            if ($this.val()) {
                helper.css('display', 'inline-block');
            } else helper.hide();
        });
        if ($this.val() != '') {
            helper.css('display', 'inline-block');
        } else helper.hide();
        helper.click(function () {
            $this.val("");
            helper.hide();
        });
    };
})(jQuery);