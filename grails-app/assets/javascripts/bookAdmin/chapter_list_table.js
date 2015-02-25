$(function() {
	$('.chapter-row').click(function(e) {
		var target = $(e.target);
		var bookId = target.data('bookid');
		var chapterId = target.data('chapterid');
		if (!chapterId) {
			chapterId = target.parent().data('chapterid');
		}
		if (!bookId) {
			bookId = target.parent().data('bookid');
		}
		if (chapterId) {
			window.location.href = '/bookAdmin/chapter/' + chapterId + "?bookId=" + bookId;
		}
	});
});