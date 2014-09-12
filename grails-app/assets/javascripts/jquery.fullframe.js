/**
 * @author Cloude
 * 
 * depend on:
 * bootstrap: http://getbootstrap.com/
 */

(function($) {
	
	function FullFrame($this, options) {
		
        this.$this = $this;
        this.options = options;
        
        var mainDiv = $('<div class="embed-responsive" style="z-index: 30; border:none; height:100%; width:100%; position:fixed; top:0px; left:0px; overflow:auto; -webkit-overflow-scrolling:touch;"></div>');
        var mainFrame = $('<iframe class="embed-responsive-item" src=""></iframe>');
        mainDiv.append(mainFrame);
        
        this.$mainDiv = mainDiv;
        this.$mainFrame = mainFrame;
    };
    
    FullFrame.prototype.openFrame = function (url) {
    		this.$mainFrame.attr('src', url);
    		$('body').append(this.$mainDiv);
    };
    
    FullFrame.prototype.closeFrame = function () {
    		this.$mainDiv.remove();
    };
	
	$.fullframe = function( options ) {
		
		var options = $.extend({
        }, options );
		
		var obj  = new FullFrame(this, options);
		return obj
	};
    
}(jQuery));