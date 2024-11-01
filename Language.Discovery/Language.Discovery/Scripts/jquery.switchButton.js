﻿(function ($, switchbutton) {
    $.widget('switchbutton.switchbutton', {
        options: { classes: '', duration: 200, dragThreshold: 5, autoResize: true, labels: true, checkedLabel: 'ON', uncheckedLabel: 'OFF', disabledClass: 'ui-switchbutton-disabled ui-state-disabled', template: '<div class="ui-switchbutton ui-switchbutton-default ${classes} {{if !labels}}ui-switchbutton-no-labels{{/if}}">' + '<label class="ui-switchbutton-disabled">' + '<span>{{if labels}}${uncheckedLabel}{{/if}}</span>' + '</label>' + '<label class="ui-switchbutton-enabled">' + '<span>{{if labels}}${checkedLabel}{{/if}}</span>' + '</label>' + '<div class="ui-switchbutton-handle"></div>' + '</div>' }, _create: function () {
            if (!this.element.is(':checkbox')) { return; }
            this._wrapCheckboxInContainer(); this._attachEvents(); this._globalEvents(); this._disableTextSelection(); if (this.element.prop('checked')) { this.$container.toggleClass('ui-state-active', this.element.prop('checked')); }
            if (this.options.autoResize) { this._autoResize(); }
            this._initialPosition();
        }, _wrapCheckboxInContainer: function () { this.$container = $.tmpl(this.options.template, this.options); this.element.after(this.$container); this.element.remove(); this.$container.append(this.element); this.$disabledLabel = this.$container.children('.ui-switchbutton-disabled'); this.$disabledSpan = this.$disabledLabel.children('span'); this.$enabledLabel = this.$container.children('.ui-switchbutton-enabled'); this.$enabledSpan = this.$enabledLabel.children('span'); this.$handle = this.$container.children('.ui-switchbutton-handle'); }, _attachEvents: function () {
            var obj = this; this.$container.bind('mousedown touchstart', function (event) {
                event.preventDefault(); if (obj.element.prop('disabled')) { return; }
                var x = event.pageX || event.originalEvent.changedTouches[0].pageX; $[switchbutton].currentlyClicking = obj.$handle; $[switchbutton].dragStartPosition = x; $[switchbutton].handleLeftOffset = parseInt(obj.$handle.css('left'), 10) || 0; $[switchbutton].dragStartedOn = obj.element;
            }).bind('iPhoneDrag', function (event, x) {
                event.preventDefault(); if (obj.element.prop('disabled')) { return; }
                if (obj.element != $[switchbutton].dragStartedOn) { return; }
                var p = (x + $[switchbutton].handleLeftOffset - $[switchbutton].dragStartPosition) / obj.rightSide; if (p < 0) { p = 0; }
                if (p > 1) { p = 1; }
                obj.$handle.css({ 'left': p * obj.rightSide }); obj.$enabledLabel.css({ 'width': p * obj.rightSide }); obj.$disabledSpan.css({ 'margin-right': -p * obj.rightSide }); obj.$enabledSpan.css({ 'margin-left': -(1 - p) * obj.rightSide });
            }).bind('iPhoneDragEnd', function (event, x) {
                if (obj.element.prop('disabled')) { return; }
                var willChangeEvent = jQuery.Event('willChange'); obj.element.trigger(willChangeEvent); if (willChangeEvent.isDefaultPrevented()) { checked = obj.element.prop('checked'); }
                else {
                    var checked; if ($[switchbutton].dragging) { var p = (x - $[switchbutton].dragStartPosition) / obj.rightSide; checked = (p < 0) ? Math.abs(p) < 0.5 : p >= 0.5; }
                    else { checked = !obj.element.prop('checked'); }
                }
                $[switchbutton].currentlyClicking = null; $[switchbutton].dragging = null; obj.element.prop('checked', checked); obj.$container.toggleClass('ui-state-active', checked); obj.element.change(); obj.element.trigger('didChange');
            }); this.element.change(function () { obj.refresh(); var new_left = obj.element.prop('checked') ? obj.rightSide : 0; obj.$handle.animate({ 'left': new_left }, obj.options.duration); obj.$enabledLabel.animate({ 'width': new_left }, obj.options.duration); obj.$disabledSpan.animate({ 'margin-right': -new_left }, obj.options.duration); obj.$enabledSpan.animate({ 'margin-left': new_left - obj.rightSide }, obj.options.duration); });
        }, _globalEvents: function () {
            if ($[switchbutton].initComplete) { return; }
            var opt = this.options; $(document).bind('mousemove touchmove', function (event) {
                if (!$[switchbutton].currentlyClicking) { return; }
                event.preventDefault(); var x = event.pageX || event.originalEvent.changedTouches[0].pageX; if (!$[switchbutton].dragging && (Math.abs($[switchbutton].dragStartPosition - x) > opt.dragThreshold)) { $[switchbutton].dragging = true; }
                $(event.target).trigger('iPhoneDrag', [x]);
            }).bind('mouseup touchend', function (event) {
                if (!$[switchbutton].currentlyClicking) { return; }
                event.preventDefault(); var x = event.pageX || event.originalEvent.changedTouches[0].pageX; $($[switchbutton].currentlyClicking).trigger('iPhoneDragEnd', [x]);
            });
        }, _disableTextSelection: function () {
            if (!$.browser.msie) { return; }
            $([this.$handle, this.$disabledLabel, this.$enabledLabel, this.$container]).attr('unselectable', 'on');
        }, _autoResize: function () {
            var onLabelWidth = this.$enabledLabel.width(), offLabelWidth = this.$disabledLabel.width(), spanPadding = this.$disabledSpan.innerWidth() - this.$disabledSpan.width()
            handleMargins = this.$handle.outerWidth() - this.$handle.innerWidth(); var containerWidth = handleWidth = (onLabelWidth > offLabelWidth) ? onLabelWidth : offLabelWidth; this.$handle.css({ 'width': handleWidth }); handleWidth = this.$handle.width(); containerWidth += handleWidth + 6; spanWidth = containerWidth - handleWidth - spanPadding - handleMargins; this.$container.css({ 'width': containerWidth }); this.$container.find('span').width(spanWidth);
        }, _initialPosition: function () {
            this.$disabledLabel.css({ width: this.$container.width() - 5 }); this.rightSide = this.$container.width() - this.$handle.outerWidth(); if (this.element.prop('checked')) { this.$handle.css({ 'left': this.rightSide }); this.$enabledLabel.css({ 'width': this.rightSide }); this.$disabledSpan.css({ 'margin-right': -this.rightSide }); }
            else { this.$enabledLabel.css({ 'width': 0 }); this.$enabledSpan.css({ 'margin-left': -this.rightSide }); }
            this.refresh();
        }, enable: function () { this.element.prop('disabled', false); this.refresh(); return this._setOption('disabled', false); }, disable: function () { this.element.prop('disabled', true); this.refresh(); return this._setOption('disabled', true); }, widget: function () { return this.$container; }, refresh: function () {
            if (this.element.prop('disabled')) { this.$container.addClass(this.options.disabledClass); return false; }
            else { this.$container.removeClass(this.options.disabledClass); }
        }
    });
})(jQuery, 'switchbutton');