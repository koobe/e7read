<ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
	<g:each in="${categorys}" var="category">
		<g:if test="${category.categorys}">
			<li class="dropdown-submenu menu-style sub-menu-item ${active?.equals(category.name)? 'activei': ''}">
				<a href="?c=${category.name}">${category.name}</a>
				<g:render template="/category/category_panel_topmenu_item" model="[categorys: category.categorys]" />
			</li>
		</g:if>
		<g:else>
			<li class="menu-style sub-menu-item ${active?.equals(category.name)? 'activei': ''}">
				<a href="?c=${category.name}">${category.name}</a>
			</li>
		</g:else>
	</g:each>
</ul>