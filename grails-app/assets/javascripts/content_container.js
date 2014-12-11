var onAuthorClick = function (event) {
    var userId = $(event.target).data('user');
    location.href = "?u=" + userId;
    event.stopPropagation();
};

var onCategoryTagClick = function (event) {
    var c = $(event.target).data('categoryname');
    location.href = "?c=" + c;
    event.stopPropagation();
};

var s = $.spinner();
var data = {};
var dataUrl = '/content/renderContentsHTML';

$(function() {
	var c = getQueryVariable("c");
	var u = getQueryVariable("u");
	var channel = getQueryVariable("channel");
	var q = getQueryVariable("q");

	if (q) {
	    data = {'q': decodeURIComponent(q)};
	    $('.fulltext-searchbox').val(decodeURIComponent(q));
	} else if (c) {
	    data = {'c': c};
	} else if (u) {
	    data = {'u': u};
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
			var dataobj = $(data);
			$('.content-author-name', dataobj).click(onAuthorClick);
	        $('.content-category-name', dataobj).click(onCategoryTagClick);
			s.done();
		}
	});
	
	$('.fulltext-searchbox').keypress(function(e) {
		if (e.keyCode == 13) {
			var target = $(e.target);
			location.href = "?q=" + target.val();
		}
	});
});
