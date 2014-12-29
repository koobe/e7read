var beforeText;

var s = $.spinner();
var data = {};
var dataUrl = '/content/renderPersonalContentsHTML';

$(function() {
	var channel = getQueryVariable("channel");
	
	if ($('#text-search').val() != '') {
	    var searchString = $('#text-search').val();
	    data = {'q': searchString};
	}
	
	data = $.extend({
		channel: channel
	}, data);

	var contentLoading = $.contentloading({
		scrollingDivId: 'display-container',
		contentDivId: 'contents_container',
		dataUrl: dataUrl,
		dataParams: data,
		beforeLoad: function() {
			s.loading();
		},
		afterLoad: function(data) {
			addHandlersOfContent();
			s.done();
		}
	});
});


var updateReferences = function() {
    var actionUrl = $(this).data('url');
    var contentId = $(this).data('id');

    var elm = $('.element-references[data-id='+contentId+']');

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

function addHandlersOfContent() {

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
	addHandlersOfContent();
}

$(function() {
   //console.log($('.inline-editing-auto-save').size());
});