<div class="hovercontent" onclick="showContent('${content.id}');">
	<div style="display: table-row;">
		<g:if test="${lr == 0}">
			<div class="content-cell-image" style="background-image:url(${content.coverUrl});" data-imageurl="${content.coverUrl}"></div>
		</g:if>
		<div class="content-cell-body" style="${(lr == 1)? 'padding-left:0px; padding-right:15px;': ''}">
			<strong><span class="text-uppercase content-title">${content.cropTitle}</span></strong>
			<div style="border-bottom: 1px solid #94E6DA;"></div>
			<div class="content-author-block">
				<span>
					<i class="fa fa-user"></i>
					<a class="content-author-name" data-user="${content.user.id}">${content.user.fullName}</a>
					&nbsp;<i class="fa fa-clock-o"></i>
					<g:formatDate date="${content.datePosted}" format="MM/dd" />
				</span>
			</div>
			<g:if test="${content.categories}">
				<div style="height: 0.5em;"></div>
				<div class="content-category-tags-table text-uppercase">
					<g:each in="${content.categories}" var="category">
						<div>
							<a class="content-category-name" data-categoryName="${category.name}">
								<span data-categoryName="${category.name}" class="label">
									<g:message code="category|${category.name}" default="${category.name}" />
								</span>
							</a>
						</div>
					</g:each>
				</div>
			</g:if>
			<div class="content-text-body">
				<p>${content.cropText}</p>
			</div>
			<div style="display:none;">
				<a href="/share/${content.id}">${content.cropTitle}</a>
			</div>
		</div>
		<g:if test="${lr == 1}">
			<div class="content-cell-image" style="background-image:url(${content.coverUrl});" data-imageurl="${content.coverUrl}"></div>
		</g:if>
	</div>
</div>