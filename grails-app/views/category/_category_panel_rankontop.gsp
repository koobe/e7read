<div class="ontop_category_table">
	<g:each in="${categories}" var="category">
		<div class="ontop_category_item">
			<a href="?c=${category.name}">
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