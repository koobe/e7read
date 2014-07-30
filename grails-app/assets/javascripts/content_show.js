var onshowiframe = false;
var scrollTop;

$(function() {
	window.addEventListener("message", receiveMessage, false);
	window.onpopstate = function(event) {
		closeIframe();
	};
});

function receiveMessage(event) {
	console.log('Receive message: ' + event.data);
}

var responsiveiframe = '<div class="div-iframe embed-responsive" style="border: 1px solid #94E6DA;height:100%; width:100%; position:fixed;top:0px;left:0px; overflow:auto;-webkit-overflow-scrolling:touch;"><iframe class="iframe embed-responsive-item" src=""></iframe></div>';
var iframe = '<iframe id="iframe-show-content" frameborder="0" style="display:none;overflow:hidden;overflow-x:hidden;overflow-y:hidden;height:100%;width:100%;position:fixed;top:0px;left:0px;right:0px;bottom:0px;z-index:999;" height="100%" width="100%"></iframe>';
var backmenu = '<div class="contentback"><div><span class="fa fa-caret-left"></span></div></div>';
var backlink = '<a id="button-back" class="koobe-btn koobe-btn-large back-btn-pos"><i class="fa fa-caret-left"></i></a>'

function showContent(contentId) {
	console.log('Open content: ' + contentId);
	
	onshowiframe = true;

	var is_safari_or_uiwebview = /(iPhone|iPod|iPad).*AppleWebKit/i.test(navigator.userAgent);
	if (is_safari_or_uiwebview) {
		$('#display-container').css('display', 'none');
		scrollTop = $(window).scrollTop();
	}
	
	
	$('body').append(responsiveiframe);
	$('body').css('overflow', 'hidden');
	$('.iframe').attr('src', '/content/embed/' + contentId);
	
	$('body').append(backlink);
	$('#button-back').click(function() {
		closeIframe();
	});
	
	history.pushState("", contentId, "/#");
}

function closeIframe() {
	var is_safari_or_uiwebview = /(iPhone|iPod|iPad).*AppleWebKit/i.test(navigator.userAgent);
	if (is_safari_or_uiwebview) {
		$('#display-container').css('display', '');
		$(window).scrollTop(scrollTop);
	}
	
	$('#button-back').remove();
	$('.div-iframe').remove();
	$('body').css('overflow', '');
	
	onshowiframe = false;
}