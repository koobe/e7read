<div class="ontop_category_table">
	<g:each in="${categories}" var="category">
		<div class="ontop_category_item" onclick="javascript: window.location.href='/?c=${category.name}'">
			<a href="/?c=${category.name}" target="_top" class="${active?.equals(category.name)? 'ontop_category_item_active': ''}">
				<g:message code="category.name.i18n.${category.name}" default="${category.name}" />
			</a>
		</div>
	</g:each>
	<div class="ontop_category_btn">
		<a href="javascript: showCategoryMenu();">
			<g:img class="btn-opensidemenu" uri="/assets/arrow.png"/>
		</a>
	</div>
</div>