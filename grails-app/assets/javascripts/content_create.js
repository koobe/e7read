var imageLimit = 3;
var s3fileId = [];
var currItem = 0;

//function appendUploadForm() {
//	var value = new Date().getTime();
//	var inputId = 'ajax-upload-input-' + value;
//	var $input = $('<input>', {
//		id: inputId,
//		type: 'file',
//		accept: 'image/*',
//		name: 'file'
//	});
//	
//	var formId = 'ajax-upload-form-' + value;
//	var $form = $('<form>', {
//		id: formId,
//		name: uploadImageForm,
//		action: '',
//		style: '',
//		enctype: 'multipart/form-data'
//	});
//}

function prepareFilesAndTriggerSubmit() {
	if ($('#uploadImageInput').val() != '') {
		ajaxUploadFile();
	}
}

function ajaxUploadFile() {
	currItem++;
	var uploadId = 'ajax-upload-display-' + new Date().getTime();
	$('.uploadImageForm').ajaxSubmit({
		beforeSend: function(){ startUpload(uploadId); },
		success: function(responseText, statusText, xhr, $form){ showResponse(responseText, statusText, xhr, $form, uploadId); },
		error: function(xhr, status, errMsg) { $('#' + uploadId).remove(); currItem--; },
		uploadProgress: function(event, position, total, percentComplete) {
	        var percentVal = percentComplete + '%';
	    }
	});
//	$('.uploadImageForm').submit();
	controlUploader();
}

function startUpload(uploadId) {
	$('.picture-add').before('<div id="' + uploadId + '" class="picture-onupload"></div>');
}

function showResponse(responseText, statusText, xhr, $form, uploadId)  {
	$('#uploadImageInput').val('');
	console.log(responseText);
	s3fileId.push(responseText.id);
	console.log(s3fileId);
	$('#' + uploadId)
        .css('background-image', 'url(' + responseText.thumbnailUrl + ')')
        .removeClass('picture-onupload')
        .addClass('picture-block')
        .click( function() { removeImage(uploadId, responseText.id); });
}

function removeImage(uploadId, id) {
	currItem--;
	$('#' + uploadId).remove();
	console.log('remove: ' + id);
	var idx = s3fileId.indexOf(id);
	s3fileId.splice(idx, 1);
	console.log(s3fileId);
	
	controlUploader();
}

function controlUploader() {
	if (currItem < imageLimit) {
		$('.picture-add').css('display', 'table-cell');
	} else {
		$('.picture-add').css('display', 'none');
	}
}

function postContent() {

    var contentText = $('#content-editing-textarea').val();
    if (!contentText || $.trim(contentText)=='') {
        alert("Please write some text in the editing area.");
        return;
    }
	
	console.log('images: ' + s3fileId);
	console.log('categorys: ' + categorys);
	
	var s3fileids = '';
	s3fileId.forEach(function(value){
		s3fileids = s3fileids + value + ",";
	});
	
	var categorysData = '';
	categorys.forEach(function(value){
		categorysData = categorysData + value + ",";
	});
	
	$.ajax({
		url: '/content/postContent',
		type:'POST',
		data: {
            id: $('meta[name=contentId]').attr('content'),
			s3fileId: s3fileids,
			categorysData: categorysData,
            references: $('input[name=references]').val(),
			contentText: $('#content-editing-textarea').val(),
            isShowLocation: $('input[name=isShowLocation]:checked').val()
		},
		success:function(data,textStatus){
			var channel = getQueryVariable("channel");
            window.location.replace($('meta[name=url2redirect]').attr('content') + "/" + channel);
            console.log(data);
        },
		error:function(XMLHttpRequest,textStatus,errorThrown){alert('error');}
	});
}

function cancelPost() {
    //TODO if nothing edited, skip the confirm step...
	var r = confirm('Discard post?');
	if (r) {
		history.back()
	}
}

var categoryLimit = 3;
var categorys = [];
var currCategorys = 0;

var categoryRemoveAction = function(e) {
    this.remove();
    if (currCategorys > 0) {
    	currCategorys--;
    }
    var idx = categorys.indexOf($(this).text());
    categorys.splice(idx, 1);
    console.log('category: ' + categorys);
    controlAddCategoryBtn();
    e.stopPropagation();
};

function addCategory(name) {
	if (categorys.indexOf(name) == -1) {
		var target = $('#category-select-item-' + name);
		currCategorys++;
		controlAddCategoryBtn();
		categorys.push(name);
		var div = '<div id="category-' + name + '" class="category-item">' + target.text() + '</div>';
		var ele = $(div).click(categoryRemoveAction);
		$('.category-add').before(ele);
	}
	console.log('category: ' + categorys);
}

function controlAddCategoryBtn() {
	if (currCategorys < categoryLimit) {
		$('.category-add').css('display', 'table-cell');
	} else {
		$('.category-add').css('display', 'none');
		hideCategoryMenu();
	}
}

$(function() {

    $('.picture-add').click(function() {
        $('#uploadImageInput').trigger('click');
    });

    $('#uploadImageInput').on('change', prepareFilesAndTriggerSubmit);

    $('.category-item').click(categoryRemoveAction);

    $('.category-item').each(function() {
        categorys.push($(this).data('category-name'));
    });
    
    $('.category-add').click(function(e) {
    	showCategoryMenu();
    	e.stopPropagation();
    });

    currCategorys = $('.category-item').size();
    currItem = $('.picture-block').size();

    if (currItem < imageLimit) {
        $('.picture-add').show();
    }

    if (currCategorys < categoryLimit) {
        $('.category-add').show();
    }

    $('.picture-block').click(function() {
        removeImage($(this).data('upload-id'), $(this).data('s3file-id'));
    });

    $('.picture-block').each(function() {
        s3fileId.push($(this).data('s3file-id'));
    });
    
});