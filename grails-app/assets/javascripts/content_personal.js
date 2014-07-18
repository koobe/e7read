$(document).ready(function() {
	if (($(window).height() - $("#contents_container").height()) >= 0) {
		triggerAjaxForData();
	}
});

var max = 4;
var page = 1;
var onCall = false;
var eof = false;
var beforeText;

$(window).scroll(function() {
	if (!eof) {determineIFTriggerAjax();}
});

// for mobile
$('body').on({
    'touchmove': function(e) { 
    	if (!eof) {determineIFTriggerAjax();}
    }
});

function determineIFTriggerAjax() {
	var factor = $(window).scrollTop() + $(window).height() + 100;
	
	if (($(document.body).height() - factor) <= 0) {
		triggerAjaxForData();
	}
}

function triggerAjaxForData() {
	if (!onCall) {
		page = page + 1;
		var offset = (page * max) - max;				
		onCall = true;
		$.ajax({
			type:'POST',
			data: { 'max': max, 'offset': offset },
			url:'/content/renderPersonalContentsHTML',
			success:function(data,textStatus){onSuccessAndAppendHTMLToContentContainer(data);},
			error:function(XMLHttpRequest,textStatus,errorThrown){}
		});
	}
}

function onSuccessAndAppendHTMLToContentContainer(data) {
	$("#contents_container").append(data);
	onCall = false;
	if (data == "") {
		console.log('EOF');
		eof = true;
	} else {
		addHandlers();
	}
}

function addHandlers() {

	$('.hovercontent').unbind('hover');
	$('.hovercontent').hover(
	    function () {
	        $(this).find('.item-editing-menu').show(250);
	    }, 
	    function () {
	        $(this).find('.item-editing-menu').hide(250);
	    }
	);

    var callback = function(data, textStatus) {
        if (data && data.id) {
            var parent = $('#content-' + data.id);
            $('.last-updated .date-value', parent).text(data.message);
        }
    };

	$('.editing-title').inlineEditing(callback);
    $('.element-text').inlineEditing(callback);
}

function deleteContent(contentid) {
	var r = confirm('Are you sure to delete?');
	if (r == true) {
		$.ajax({
			type:'POST',
			data: { 'contentid': contentid },
			url: '/content/disableContent',
			success:function(data,textStatus){$("div[contentid='"+ contentid +"']").remove();},
			error:function(XMLHttpRequest,textStatus,errorThrown){}
		});
	}
}

function switchPrivacy(contentid) {
	var r = confirm('Are you sure?');
	if (r == true) {
		$.ajax({
			type:'POST',
			data: { 'contentid': contentid },
			url: '/content/switchPrivacy',
			success:function(data,textStatus){refreshButtons(data, contentid);},
			error:function(XMLHttpRequest,textStatus,errorThrown){}
		});
	}
}

function refreshButtons(data, contentid) {
	$("div[contentid='"+ contentid +"']").html(data);
	// need to concern about performance
	addHandlers();
}

$(function() {
   console.log($('.inline-editing-auto-save').size());
});