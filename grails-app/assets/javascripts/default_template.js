$(function() {
    $('a.content-category').click(function() {
        window.open("/?c="+$(this).data('category-name'), '_top');
    });

    var logo = $("<img src=\"/assets/logo_white.png\" alt=\"logo\" class=\"e7read-logo\" />");
    logo.click(function() {
        window.open("/", '_top');
    });
    $('body').append(logo);

});