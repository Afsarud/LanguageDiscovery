﻿/**
* simplePagination.js v1.6
* A simple jQuery pagination plugin.
* http://flaviusmatis.github.com/simplePagination.js/
*
* Copyright 2012, Flavius Matis
* Released under the MIT license.
* http://flaviusmatis.github.com/license.html
*/

(function($){

	var methods = {
		init: function(options) {
		    var o = $.extend({
                displayLastPages: true,
				items: 1,
				itemsOnPage: 1,
				pages: 0,
				displayedPages: 5,
				edges: 1,
				currentPage: 1,
				hrefTextPrefix: '#page-',
				hrefTextSuffix: '',
				prevText: 'Prev',
				nextText: 'Next',
                lastPageText: 'Go to last page',
                firstPageText: 'Go to first page',
				ellipseText: '&hellip;',
                cssStyle: 'light-theme',
                orientation: 'horizontal',
				labelMap: [],
				selectOnClick: true,
				onPageClick: function(pageNumber, event) {
					// Callback triggered when a page is clicked
					// Page number is given as an optional parameter
				},
				onInit: function() {
					// Callback triggered immediately after initialization
				}
			}, options || {});

			var self = this;

			o.pages = o.pages ? o.pages : Math.ceil(o.items / o.itemsOnPage) ? Math.ceil(o.items / o.itemsOnPage) : 1;
			o.currentPage = o.currentPage - 1;
			o.halfDisplayed = o.displayedPages / 2;

			this.each(function() {
				self.addClass(o.cssStyle + ' simple-pagination').data('pagination', o);
				methods._draw.call(self);
			});

			o.onInit();

			return this;
		},

		selectPage: function(page) {
			methods._selectPage.call(this, page - 1);
			return this;
		},

		prevPage: function() {
			var o = this.data('pagination');
			if (o.currentPage > 0) {
				methods._selectPage.call(this, o.currentPage - 1);
			}
			return this;
		},

		nextPage: function() {
			var o = this.data('pagination');
			if (o.currentPage < o.pages - 1) {
				methods._selectPage.call(this, o.currentPage + 1);
			}
			return this;
		},

		getPagesCount: function() {
			return this.data('pagination').pages;
		},

		getCurrentPage: function () {
			return this.data('pagination').currentPage + 1;
		},

		destroy: function(){
			this.empty();
			return this;
		},

		drawPage: function (page) {
			var o = this.data('pagination');
			o.currentPage = page - 1;
			this.data('pagination', o);
			methods._draw.call(this);
			return this;
		},

		redraw: function(){
			methods._draw.call(this);
			return this;
		},

		disable: function(){
			var o = this.data('pagination');
			o.disabled = true;
			this.data('pagination', o);
			methods._draw.call(this);
			return this;
		},

		enable: function(){
			var o = this.data('pagination');
			o.disabled = false;
			this.data('pagination', o);
			methods._draw.call(this);
			return this;
		},

		updateItems: function (newItems) {
			var o = this.data('pagination');
			o.items = newItems;
			o.pages = methods._getPages(o);
			this.data('pagination', o);
			methods._draw.call(this);
		},

		updateItemsOnPage: function (itemsOnPage) {
			var o = this.data('pagination');
			o.itemsOnPage = itemsOnPage;
			o.pages = methods._getPages(o);
			this.data('pagination', o);
			methods._selectPage.call(this, 0);
			return this;
		},

		_draw: function() {
			var	o = this.data('pagination'),
				interval = methods._getInterval(o),
				i,
				tagName;
		    //interval.start = 1;
			
			methods.destroy.call(this);
			
			tagName = (typeof this.prop === 'function') ? this.prop('tagName') : this.attr('tagName');

			var $panel = tagName === 'UL' ? this : $('<ul></ul>').appendTo(this);

            var orientationClass = " horizontaldirection";
            if (o.orientation == "vertical")
                orientationClass = " verticaldirection";


            if (o.firstPageText) {
                methods._appendItem.call(this, 0, { text: o.firstPageText, classes: (o.orientation == "vertical" ? "hasShadow " : orientationClass) });
            }

			// Generate Prev link
            if (o.prevText) {
                methods._appendItem.call(this, o.currentPage - 1, { text: o.prevText, classes: 'prev' + orientationClass });
			}

			// Generate start edges
			if (interval.start > 0 && o.edges > 0) {
				var end = Math.min(o.edges, interval.start);
				for (i = 0; i < end; i++) {
					methods._appendItem.call(this, i);
				}
				if (o.displayLastPages) {
				    if (o.edges < interval.start && (interval.start - o.edges != 1)) {
				        $panel.append('<li class="disabled"><span class="ellipse">' + o.ellipseText + '</span></li>');
				    } else if (interval.start - o.edges == 1) {
				        methods._appendItem.call(this, o.edges);
				    }
				}
			}
		
			// Generate interval links
			for (i = interval.start; i < interval.end; i++) {
				methods._appendItem.call(this, i);
			}

			// Generate end edges
			if (interval.end < o.pages && o.edges > 0) {
			    if (o.pages - o.edges > interval.end && (o.pages - o.edges - interval.end != 1)) {
					$panel.append('<li class="disabled"><span class="ellipse">' + o.ellipseText + '</span></li>');  
				} else if (o.pages - o.edges - interval.end == 1) {
				    if (o.displayLastPages)
					    methods._appendItem.call(this, interval.end++);
				}
				var begin = Math.max(o.pages - o.edges, interval.end);
				for (i = begin; i < o.pages; i++) {
				    //if (o.displayLastPages)
					    //methods._appendItem.call(this, i);
				}
			}


			// Generate Next link
            if (o.nextText) {
                methods._appendItem.call(this, o.currentPage + 1, { text: o.nextText, classes: 'next' + orientationClass });
			}

            if (o.lastPageText) {
                methods._appendItem.call(this, o.pages - 1, { text: o.lastPageText, classes: (o.orientation == "vertical" ? "hasShadow" : orientationClass) });
            }
        },

		_getPages: function(o) {
			var pages = Math.ceil(o.items / o.itemsOnPage);
			return pages || 1;
		},

		_getInterval: function(o) {
			return {
				start: Math.ceil(o.currentPage > o.halfDisplayed ? Math.max(Math.min(o.currentPage - o.halfDisplayed, (o.pages - o.displayedPages)), 0) : 0),
				end: Math.ceil(o.currentPage > o.halfDisplayed ? Math.min(o.currentPage + o.halfDisplayed, o.pages) : Math.min(o.displayedPages, o.pages))
			};
		},

		_appendItem: function(pageIndex, opts) {
			var self = this, options, $link, o = self.data('pagination'), $linkWrapper = $('<li></li>'), $ul = self.find('ul');

			pageIndex = pageIndex < 0 ? 0 : (pageIndex < o.pages ? pageIndex : o.pages - 1);

			options = {
				text: pageIndex + 1,
				classes: ''
			};

			if (o.labelMap.length && o.labelMap[pageIndex]) {
				options.text = o.labelMap[pageIndex];
			}

			options = $.extend(options, opts || {});
			
			if (pageIndex == o.currentPage || o.disabled) {
				if (o.disabled) {
					$linkWrapper.addClass('disabled');
				} else {
					$linkWrapper.addClass('active');
				}
				$link = $('<span class="current">' + (options.text) + '</span>');

				$linkWrapper.append($link);
            } else {
                var orientationClass = '';
                if (o.orientation == 'vertical')
                    orientationClass = ' vertical';
                $link = $('<a href="' + o.hrefTextPrefix + (pageIndex + 1) + o.hrefTextSuffix + '" class="page-link' + orientationClass + '">' + (options.text) + '</a>');
				$link.click(function(event){
					return methods._selectPage.call(self, pageIndex, event);
				});

				$linkWrapper.append($link);
			}

			if (options.classes) {
				$link.addClass(options.classes);
			}

			if (!o.displayLastPages && pageIndex == o.currentPage && pageIndex > 1 || o.disabled) {
			    $link.remove();
			}

			//$linkWrapper.append($link);
			    
			if ($ul.length) {
			    $ul.append($linkWrapper);
			} else {
                if(o.displayLastPages)
			        self.append($linkWrapper);
			}
			
		},

		_selectPage: function(pageIndex, event) {
			var o = this.data('pagination');
			o.currentPage = pageIndex;
			if (o.selectOnClick) {
				methods._draw.call(this);
			}
			return o.onPageClick(pageIndex + 1, event);
		}

	};

	$.fn.pagination = function(method) {

		// Method calling logic
		if (methods[method] && method.charAt(0) != '_') {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
		} else if (typeof method === 'object' || !method) {
			return methods.init.apply(this, arguments);
		} else {
			$.error('Method ' +  method + ' does not exist on jQuery.pagination');
		}

	};

})(jQuery);
