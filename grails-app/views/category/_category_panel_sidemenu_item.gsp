<ul>
	<g:each in="${categorys}" var="category">
		<g:if test="${category.enable}">
			<g:if test="${category.categorys}">
				<li class="${active?.equals(category.name)? 'active-item': ''}">
					<a id="category-select-item-${category.name}" data-category="${category.name}" class="gotocategorylink" href="${btnaction?.equals('create')? 'javascript: addCategory("'+ category.name +'")': '?c=' + category.name + '&p=1'}" target="_top">
						<g:message code="category|${category.name}" default="${category.name}" />
					</a>
					<g:render template="/category/category_panel_sidemenu_item" model="[categorys: category.categorys]" />
				</li>
			</g:if>
			<g:else>
				<li class="${active?.equals(category.name)? 'active-item': ''}">
					<a id="category-select-item-${category.name}" data-category-name="${category.name}" class="gotocategorylink" href="${btnaction?.equals('create')? 'javascript: addCategory("'+ category.name +'")': '?c='+category.name+'&p=1'}" target="_top">
						<g:message code="category|${category.name}" default="${category.name}" />
					</a>
				</li>
			</g:else>
		</g:if>
	</g:each>
</ul>