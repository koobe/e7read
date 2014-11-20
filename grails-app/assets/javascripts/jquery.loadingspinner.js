/**
 * @author Cloude
 */

(function($) {

	function Spinner($this, options) {
		
		var maindiv = $('<div/>').addClass('loading-spinner-maindiv');
		var imgdiv = $('<div><i class="fa fa-spinner fa-spin"></i></div>').addClass('loading-spinner-imgdiv');
		var messagediv = $('<div/>').addClass('loading-spinner-messagediv');
		var messagespan = $('<span/>').addClass('loading-spinner-messagespan');
		
		this.$this = $this;
		this.options = options;
		
		this.maindiv = maindiv;
		this.imgdiv = imgdiv;
		this.messagediv = messagediv;
		this.messagespan = messagespan;
		
		if (!this.options.showIcon) {
			this.imgdiv.css('display', 'none');
		}
		this.maindiv.css('bottom', this.options.bottom);
		this.maindiv.css('background-color', this.options.bgColor);
		
		this.messagediv.css('padding-left', this.options.msgLeftPadding);
	}

	Spinner.prototype.loading = function(message) {
		this.show(message);
	};

	Spinner.prototype.done = function() {
		this.hide();
	}

	Spinner.prototype.show = function(message) {
		if (message) {
			this.messagespan.text(message);
		} else {
			this.messagespan.text(this.options.defaultMsg);
		}

		$('body').append(
				this.maindiv.append(this.imgdiv).append(this.messagediv.append(this.messagespan)));

		var margin_l = -(this.maindiv.width() / 2);
		this.maindiv.css('margin-left', margin_l + 'px');
	}

	Spinner.prototype.hide = function() {
		
		var maindiv = this.maindiv;
		
		if (this.options.isTimeout) {
			setTimeout(function() {
				maindiv.remove();
			}, this.options.fadeTime);
		} else {
			maindiv.remove();
		}
	}

	$.spinner = function(options) {

		var options = $.extend({
			bottom : '20px',
			msgLeftPadding: '15px',
			fadeTime : 800,
			isTimeout: true,
			// rgba(148, 230, 218, 0.7)
			bgColor: 'rgba(1,1,1,0.3)',
			showIcon: true,
			defaultMsg: 'Loading ...'
		}, options);

		return new Spinner(this, options);
	};

}(jQuery));