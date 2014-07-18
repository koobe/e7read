$(document).ready(function() {
	window.addEventListener("message", receiveMessage, false);
});

function receiveMessage(event) {
	console.log('Receive message: ' + event.data);
//	$('#iframe-show-content').attr('src', '/content/show/' + contentId);
//	$('#iframe-show-content').css('display', 'none');
	$('#iframe-show-content').remove();
	$('body').css('overflow', '');
}

var iframe = '<iframe id="iframe-show-content" frameborder="0" style="display:none;overflow:hidden;overflow-x:hidden;overflow-y:hidden;height:100%;width:100%;position:fixed;top:0px;left:0px;right:0px;bottom:0px;z-index:999;" height="100%" width="100%"></iframe>';

function showContent(contentId) {
	
	$('body').css('overflow', 'hidden');
	$('body').append(iframe);
	
//	var scrollTop = $(window).scrollTop();
//	$('#iframe-show-content').css('top', scrollTop + 'px');
	
	$('#iframe-show-content').css('display', '');
	$('#iframe-show-content').attr('src', '/content/show/' + contentId);
}