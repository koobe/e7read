<ul>
	<g:each in="${categorys}" var="category">
		<g:if test="${category.categorys}">
			<li class="${active?.equals(category.name)? 'active-item': ''}">
				<a href="?c=${category.name}&p=1">${category.name}</a>
				<g:render template="/category/category_panel_sidemenu_item" model="[categorys: category.categorys]" />
			</li>
		</g:if>
		<g:else>
			<li class="${active?.equals(category.name)? 'active-item': ''}">
				<a href="?c=${category.name}&p=1">${category.name}</a>
			</li>
		</g:else>
	</g:each>
</ul>