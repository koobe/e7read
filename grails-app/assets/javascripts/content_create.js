var imageLimit = 3;
var s3fileId = [];
var currItem = 0;

$(function() {
	$('.picture-add').on('click', function() {
		$('#uploadImageInput').trigger('click');
	});
	$('#uploadImageInput').on('change', prepareFilesAndTriggerSubmit);
});

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
	$('#' + uploadId).css('background-image', 'url(' + responseText.url + ')');
	$('#' + uploadId).attr('class', 'picture-block');
	$('#' + uploadId).on('click', function() {
		removeImage(uploadId, responseText.id);
	});
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
	console.log(s3fileId);
	var s3fileids = '';
	s3fileId.forEach(function(value){
		s3fileids = s3fileids + value + ",";
	});
	$.ajax({
		url: '/content/postContent',
		type:'POST',
		data: {
			s3fileId: s3fileids,
            references: $('input[name=references]').val(),
			contentText: $('#content-editing-textarea').val()
		},
		success:function(data,textStatus){window.location.replace("/content/personal");},
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