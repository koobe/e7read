/**
 * @author Cloude
 */

(function($) {

	function LogoPanel($this, options) {
		
		var divcatestatusindicator = $('<div/>').addClass('category-status-panel');
		divcatestatusindicator.css('position', options.position);
		
	    var logodivcell = $('<div class="logoimg-div"/>').addClass('table-cell');
	    var logoimg = $('<img src="' + options.logoIconUrl + '" alt="logo" class="e7read-logo" />');
	    
	    var cellopensidemenu = $('<div class="table-cell"><img src="/assets/grey_arrow.png" class="category-status-catebtn"></div>');
		
	    divcatestatusindicator.append(logodivcell.append(logoimg)).append(cellopensidemenu);
	    
	    this.options = options;
	    this.logodivcell = logodivcell;
	    this.logoimg = logoimg;
	    this.cellopensidemenu = cellopensidemenu;
	    this.mainContainer = divcatestatusindicator;
	}

	LogoPanel.prototype.show = function() {
		
		var me = this;
		
		$('body').append(this.mainContainer);
		
		$('.e7read-logo', this.logodivcell).unbind('click').click(function(e) {
	    	window.open("/" + me.options.channel, '_top');
	    	e.stopPropagation();
	    });
	    
	    $('.category-status-catebtn', this.cellopensidemenu).unbind('click').click(function(e) {
	    	showCategoryMenu();
	    	e.stopPropagation();
	    });
	}

	LogoPanel.prototype.hide = function() {
		this.mainContainer.remove();
	}

	$.logopanel = function(options) {
		
		var options = $.extend({
			position: 'fixed',
			left : '0px',
			right: '0px',
			logoIconUrl: ''
		}, options);

		return new LogoPanel(this, options);
	};

}(jQuery));