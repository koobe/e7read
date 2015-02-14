$(function() {
	$('.date-picker>select').addClass('form-control');

	$('.confirm-button').click(function() {
		var c = confirm("確認通過審核");
		if (c) {
			$('#isChecked').val('true');
			$('.save-button').click();
		}
	});

	$('.delete-button').click(function() {
		var c = confirm("是否刪除");
		if (c) {
			$('#isDelete').val('true');
			$('.save-button').click();
		}
	});
});