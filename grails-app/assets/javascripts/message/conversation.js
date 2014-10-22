$(function() {
	
	fitContent();
	scrollToBottom();
	
	$(window).unbind('resize').resize(function(){
		fitContent();
	});
	
	function fitContent() {
		var messageContentHeight = $('body').height() - $('nav').height() -$('footer').height();
		$('.message-content-container').height(messageContentHeight);
	}
	
	function scrollToBottom() {
		$('.message-content-container').scrollTop($('.message-content').height());
	}
});

