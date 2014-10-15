<div class="content-category-tags-table text-uppercase">
	<g:each in="${content.categories}" var="category">
		<div>
			<a class="content-category-name" data-categoryName="${category.name}">
				<span data-categoryName="${category.name}" class="label">
					<g:message code="category.name.i18n.${category.name}" default="${category.name}" />
				</span>
			</a>
		</div>
	</g:each>
</div>