/**
 * @author Cloude
 */

(function($) {
	
	var default_msg = "now loading...";
	var maindiv = $('<div/>').addClass('loading-spinner-maindiv');
	var imgdiv = $('<div><i class="fa fa-spinner fa-spin"></i></div>').addClass('loading-spinner-imgdiv');
	var messagediv = $('<div/>').addClass('loading-spinner-messagediv');
	var messagespan = $('<span/>').addClass('loading-spinner-messagespan');
	
	function Spinner($this, options) {
        this.$this = $this;
        this.options = options;
    };
    
    Spinner.prototype.loading = function () {
        console.log('loading');
        messagespan.text(default_msg);
        
        $('body').append(maindiv.append(imgdiv).append(messagediv.append(messagespan)));
        
        var margin_l = -(maindiv.width() / 2);
        maindiv.css('margin-left', margin_l + 'px');
     };
     
     Spinner.prototype.done = function() {
    	 setTimeout(function(){maindiv.remove();}, 800);
     }
	
	$.spinner = function( options ) {
		return new Spinner(this, options);
	};
    
}(jQuery));