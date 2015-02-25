<div class="nav-panel">
	<g:if test="${session?.bookAdminNavigation?.prevAction}">
		<div class="nav-link">
			<g:link controller="bookAdmin"
				action="${session?.bookAdminNavigation?.prevAction}"
				params="${session?.bookAdminNavigation?.params}">
				<g:if test="${session?.bookAdminNavigation?.prevAction == 'newBookList'}">
								新書
				</g:if>
				<g:if test="${session?.bookAdminNavigation?.prevAction == 'bookList'}">
								電子書
				</g:if>
			</g:link>
		</div>
		<div class="nav-link">&gt;</div>
	</g:if>
	<g:if test="${middlePageUri}">
		<div class="nav-link">
			<g:link uri="${middlePageUri}">${middlePageLinkName}</g:link>
		</div>
		<div class="nav-link">&gt;</div>
	</g:if>
	<div class="nav-link">
		${displayName}
		<g:if test="${appendDisplayName}">
			(${appendDisplayName})
		</g:if>
	</div>
</div>