<div class="hovercontent" onclick="showContent('${it.id}');">
	<div style="display: table-row;">
		<div class="content-cell-image" style="background-image:url(${it.coverUrl});"></div>
		<div class="content-cell-body">
			<strong><span class="text-uppercase content-title">${it.cropTitle}</span></strong>
			<div style="border-bottom: 1px solid #94E6DA;"></div>
			<div class="content-author-block">
				<span>
					<i class="fa fa-user"></i>
					<a class="content-author-name" data-user="${it.user.id}">${it.user.fullName}</a>
					&nbsp;<i class="fa fa-clock-o"></i>
					<g:formatDate date="${it.lastUpdated}" format="MM/dd" />
				</span>
			</div>
			<g:if test="${it.categories}">
				<div class="content-category-tags-table text-uppercase">
					<g:each in="${it.categories}" var="category">
						<div>
							<a class="content-category-name" data-categoryName="${category.name}">
								<span data-categoryName="${category.name}" class="label">${category.name}</span>&nbsp;
							</a>
						</div>
					</g:each>
				</div>
			</g:if>
			<div class="content-text-body">
				<p>${it.cropText}</p>
			</div>
		</div>
	</div>
</div>