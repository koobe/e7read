<div class="ontop_category_table">
	<g:each in="${categories}" var="category">
		<div class="ontop-category-item">
            <g:link controller="home" action="index" params="${[c: category.name]}" target="_top" class="category-link-item${category.name?.equalsIgnoreCase("${activeCategoryName}")?' active':''}" data-category="${category.name}">
                <g:message code="category|${category.name}" default="${category.name}" />
            </g:link>
		</div>
	</g:each>
	<div class="ontop_category_btn header-menu-category">
		<a href="javascript: showCategoryMenu();">
			<g:img class="btn-opensidemenu" uri="/assets/arrow.png"/>
		</a>
	</div>
</div>