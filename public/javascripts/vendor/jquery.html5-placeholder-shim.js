//https://github.com/parndt/jquery-html5-placeholder-shim
(function($) {
	$.extend($,{ placeholder: {
			browser_supported: function() {
				return this._supported !== undefined ?
					this._supported :
					( this._supported = !!('placeholder' in $('<input type="text">')[0]) );
			},
			shim: function(opts) {
				var config = {
					color: '#888',
					cls: 'placeholder_shim',
					lr_padding:4,
					selector: 'input[placeholder], textarea[placeholder]'
				};
				$.extend(config,opts);
				!this.browser_supported() && $(config.selector)._placeholder_shim(config);
			}
	}});

	$.extend($.fn,{
		_placeholder_shim: function(config) {
			function calcPositionCss(target)
			{
				var t = $(target),
						op = t.offsetParent().offset(),
						ot = t.offset();

				return {
					top: ot.top - op.top + (t.outerHeight() - t.height()) /2,
					left: ot.left - op.left + parseInt(t.css('paddingLeft')) + config.lr_padding,
					width: t.width() - (config.lr_padding * 2)
				};
			}
			return this.each(function() {
				
				if( $(this).data('placeholder') ) {
					var $ol = $(this).data('placeholder');
					$ol.css(calcPositionCss($(this)));
					return true;
				}
				
				var ol = $('<label />')
					.text($(this).attr('placeholder'))
					.addClass(config.cls)
					.css({
						position:'absolute',
						display: 'inline',
						float:'none',
						overflow:'hidden',
						whiteSpace:'nowrap',
						textAlign: 'left',
						color: config.color,
						cursor: 'text',
						fontSize: $(this).css('font-size')
					})
					.css(calcPositionCss(this))
//					.attr('for', this.id)
					.data('target',$(this))
					.click(function(){
						$(this).data('target').focus()
					})
					.insertBefore(this);
				$(this)
					.data('placeholder',ol)
					.focus(function(){
						$(config.selector).not(this).trigger('blur');
						ol.hide();
					}).blur(function() {
						ol[$(this).val().length ? 'hide' : 'show']();
					}).triggerHandler('blur');
				$(window)
					.resize(function() {
						var $target = ol.data('target')
						ol.css(calcPositionCss($target))
					});
			});
		}
	});

})(jQuery);