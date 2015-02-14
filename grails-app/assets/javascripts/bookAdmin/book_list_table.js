$(function() {
	$('.book-row').click(function(e) {
		var target = $(e.target);
		var bookId = target.data('bookid');
		if (!bookId) {
			bookId = target.parent().data('bookid');
		}
		if (bookId) {
			window.location.href = '/bookAdmin/book/' + bookId;
		}
	});
});