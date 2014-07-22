var onshowiframe = false;

$(function() {
	window.addEventListener("message", receiveMessage, false);
	window.onbeforeunload = function(event) {
		/**
		 * Handling the back button event of browser
		 */
//		if (onshowiframe) {
//			$('#iframe-show-content').remove();
//			$('body').css('overflow', '');
//			event.stopPropagation();
//			event.preventDefault();
//		}
	};
});

function receiveMessage(event) {
	console.log('Receive message: ' + event.data);
	$('#iframe-show-content').remove();
	$('body').css('overflow', '');
	
	onshowiframe = false;
}

var iframe = '<iframe id="iframe-show-content" frameborder="0" style="display:none;overflow:hidden;overflow-x:hidden;overflow-y:hidden;height:100%;width:100%;position:fixed;top:0px;left:0px;right:0px;bottom:0px;z-index:999;" height="100%" width="100%"></iframe>';

function showContent(contentId) {
	
	console.log('Open content: ' + contentId);
	onshowiframe = true;
	
	$('body').append(iframe);
	$('body').css('overflow', 'hidden');
	$('#iframe-show-content').css('display', '');
	$('#iframe-show-content').attr('src', '/content/show/' + contentId);
}