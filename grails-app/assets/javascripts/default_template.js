$(function() {
   $('a.content-category').click(function() {
       window.open("/?c="+$(this).data('category-name'), '_top');
   });
});