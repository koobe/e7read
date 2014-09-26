var onAuthorClick = function (event) {
    var userId = $(event.target).data('user');
    location.href = "?u=" + userId;
    event.stopPropagation();
};

var onCategoryTagClick = function (event) {
    var c = $(event.target).data('categoryname');
    location.href = "/c/" + c;
    event.stopPropagation();
};

var s = $.spinner();
var data = {};
var dataUrl = '/content/renderContentsHTML';

$(function() {
	var c = getQueryVariable("c");
	var u = getQueryVariable("u");

	if ($('#text-search').val() != '') {
	    var searchString = $('#text-search').val();
	    data = {'q': searchString};
	} else if (c) {
	    data = {'c': c};
	} else if (u) {
	    data = {'u': u};
	}

	var contentLoading = $.contentloading({
		scrollingDivId: 'display-container',
		contentDivId: 'contents_container',
		dataUrl: dataUrl,
		dataParams: data,
		beforeLoad: function() {
			s.loading();
		},
		afterLoad: function(data) {
			var dataobj = $(data);
			$('.content-author-name', dataobj).click(onAuthorClick);
	        $('.content-category-name', dataobj).click(onCategoryTagClick);
			s.done();
		}
	});
});
