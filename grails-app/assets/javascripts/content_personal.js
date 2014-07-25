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
		onCall = true;
		
		page = page + 1;
		var offset = (page * max) - max;				
		
		if ($('#text-search').val() != '') {
			var searchString = $('#text-search').val();
			data = {'q': searchString, 'from': offset, 'size': max};
		} else {
			data = {'max': max, 'offset': offset};
		}
		
		$.ajax({
			type:'POST',
			data: data,
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


    $('.button-modify-references').unbind('click').click(function() {
        var actionUrl = $(this).data('url');
        var contentId = $(this).data('id');

        var elm = $('.element-references[data-id='+contentId+']');
        
//        var msg;
//        if ($('a', elm).attr('href') == undefined) {
//        	msg = '';
//        } else {
//        	msg = $('a', elm).attr('href');
//        }

        var url = prompt('Reference URL:', $('a', elm).attr('href'));

        if (url != null) {
            $.ajax({
                type: 'POST',
                data: {
                    'references': url
                },
                url: actionUrl,
                success: function(data, textStatus) {
                    var references = data.instance.references

                    if (references) {
                    	elm.show();
//                        $('i', elm).show();
                        $('a', elm).text('Link').attr('href', references).show();
                    }
                    else {
                    	elm.hide();
//                        $('i', elm).hide();
                        $('a', elm).text('').attr('href', '#').hide();
                    }
                }
            });
        }

        return false;
    });

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
//	var r = confirm('Are you sure?');
//	if (r == true) {
		$.ajax({
			type:'POST',
			data: { 'contentid': contentid },
			url: '/content/switchPrivacy',
			success:function(data,textStatus){refreshButtons(data, contentid);},
			error:function(XMLHttpRequest,textStatus,errorThrown){}
		});
//	}
}

function refreshButtons(data, contentid) {
	$("div[contentid='"+ contentid +"']").html(data);
	// need to concern about performance
	addHandlers();
}

$(function() {
   console.log($('.inline-editing-auto-save').size());
});