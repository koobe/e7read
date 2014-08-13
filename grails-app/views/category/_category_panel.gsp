<asset:stylesheet src="submenu.css" />
<asset:stylesheet src="category_sidemenu.css" />
<asset:stylesheet src="topcategorymenu.css" />
<script type="text/javascript">
	function hideCategoryMenu() {
		$('.side-menu-float').hide(400);
	}
	function showCategoryMenu() {
		$('.side-menu-float').show(400);
	}

	$(function() {
		$('.topmenu-li').hover(
			function(e) {

				var el = $(e.target);
				if (el.prop("tagName") == "LI") {
					el = $('a', el);
				}
				var pos = el.position();
				$(this).find('.dropdown-menu').first().css('display','block').css('top', pos.top + el.height() - 2).css('left', pos.left);
			}, function(e) {
				$(this).find('.dropdown-menu').first().css('display','none');
			}
		);
	});
</script>
<div id="category_panel" class="container-fluid" style="padding-left: 40px; background-color: #94E6DA; padding-top: 5px; padding-bottom: 5px;">
	<g:include controller="category" action="showCategory" />
</div>