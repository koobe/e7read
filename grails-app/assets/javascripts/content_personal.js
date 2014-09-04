var s = $.spinner();

$(document).ready(function() {
	if (($(window).height() - $("#contents_container").height()) >= 0) {
		triggerAjaxForData();
	}
	
	$('body').css('height', 'auto');
});

var max = 4;
var page = 0;
var onCall = false;
var eof = false;
var beforeText;

$(function() {
    $('#display-container')
        .scroll(function() {
            if (!eof) {determineIFTriggerAjax();}
        })
        .on({
            'touchmove': function(e) {
                if (!eof) {determineIFTriggerAjax();} // for mobile
            }
        });
});

function determineIFTriggerAjax() {

    var scrollContainer = $('#display-container');
    var contentPane = $('#display-container .content-pane');

    var factor = scrollContainer.scrollTop() + scrollContainer.height() + 100;

    //console.log('scrollContainer.scrollTop()  ' + scrollContainer.scrollTop());
    //console.log('$(window).height()  ' + $(window).height());
    //console.log('factor  ' + factor);
    //console.log('$(document.body).height()  ' + $(document.body).height());
    //console.log('$(\'#display-container\').height()  ' + $('#display-container').height());
    //console.log(contentPane.height());

    if ((contentPane.height() - factor) <= 0) {
        triggerAjaxForData();
    }
}

function triggerAjaxForData() {
	if (!onCall) {
		
		s.loading();
		
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
	s.done();
}

var updateReferences = function() {
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
    
    if (url == '#') {
    	return;
    }

    if (url != null) {
        $.ajax({
            type: 'POST',
            data: {
                'references': url
            },
            url: actionUrl,
            success: function(data, textStatus) {
//                var references = data.instance.references
//
//                if (references) {
//                    elm.show();
////                        $('i', elm).show();
//                    $('a', elm).text('Link').attr('href', references).show();
//                }
//                else {
//                    elm.hide();
////                        $('i', elm).hide();
//                    $('a', elm).text('').attr('href', '#').hide();
//                }
            	
            	refreshButtons(data, contentId);
            }
        });
    }

    return false;
};

var updateShowContact = function() {
    var actionUrl = $(this).data('url');
    var contentId = $(this).data('id');
//    var value = $(this).val();
    var value = $(this).data('value');

    $.ajax({
        type: 'POST',
        data: {
            'isShowContact': value
        },
        url: actionUrl,
        success: function(data, textStatus) {
            //console.log(data);
        	refreshButtons(data, contentId);
        }
    });
    
    return false;
};

function addHandlers() {

	$('.hovercontent').unbind('hover').hover(
	    function () {
            $(this).find('.advanced-options').show();
	        $(this).find('.item-editing-menu').show(250);
	    }, 
	    function () {
            $(this).find('.advanced-options').hide();
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

    $('.button-modify-references').unbind('click').click(updateReferences);

//    $('input[name=isShowContact]').unbind('change').change(updateShowContact);
    $('.button-show-contact').unbind('click').click(updateShowContact);
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
   //console.log($('.inline-editing-auto-save').size());
});