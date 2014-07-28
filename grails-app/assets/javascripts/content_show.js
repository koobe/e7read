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
}

var responsiveiframe = '<div class="div-iframe embed-responsive" style="height:100%; width:100%; position:fixed;top:0px;left:0px; overflow:auto;-webkit-overflow-scrolling:touch;"><iframe class="iframe embed-responsive-item" src=""></iframe></div>';
var iframe = '<iframe id="iframe-show-content" frameborder="0" style="display:none;overflow:hidden;overflow-x:hidden;overflow-y:hidden;height:100%;width:100%;position:fixed;top:0px;left:0px;right:0px;bottom:0px;z-index:999;" height="100%" width="100%"></iframe>';
var backmenu = '<div class="contentback"><div><span class="fa fa-caret-left"></span></div></div>';
var backlink = '<a id="button-back" href="#" class="koobe-btn back-btn-pos"><i class="fa fa-caret-left"></i></a>'

function showContent(contentId) {
	console.log('Open content: ' + contentId);
	
	onshowiframe = true;
//	
//	$('body').append(iframe);
//	$('body').css('overflow', 'hidden');
//	$('#iframe-show-content').css('display', '');
//	$('#iframe-show-content').attr('src', '/content/show/' + contentId);
	
	$('body').append(responsiveiframe);
	$('body').css('overflow', 'hidden');
//	$('.div-iframe').css('display', '');
//	$('.iframe').attr('src', '/content/show/' + contentId);
	$('.iframe').attr('src', '/content/embed/' + contentId);
	
//	$('.iframe').wrap(function(){
//        var $this = $(this);
//        return $('<div />').css({
//            width: $this.attr('width'),
//            height: $this.attr('height'),
//            overflow: 'auto',
//            '-webkit-overflow-scrolling': 'touch'
//        });
//    });
	
	$('body').append(backlink);
	$('#button-back').click(function() {
		closeIframe();
	});
}

function closeIframe() {
	
	$('#button-back').remove();
	$('.div-iframe').remove();
//	$('.div-iframe').css('display', 'none');
	$('body').css('overflow', '');
	
	onshowiframe = false;
}