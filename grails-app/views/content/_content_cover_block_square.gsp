<div class="content-cover-block-square col-xs-12 col-sm-4 col-md-3">
	<div class="block-body" onclick="showContent('${content.id}');">
		<div class="div-bg-thumbnail-cover block-title-image" style="
			background-image:url(${content.pictureSegments[0]?.thumbnailUrl? content.pictureSegments[0]?.thumbnailUrl: content.pictureSegments[0]?.originalUrl});
			height: 170px;
			width: 100%;
		">
			<div class="block-image-title">
				<div class="title">${content.cropTitle}</div>
				<div class="location">Taipei</div>
			</div>
		</div>
		<div class="block-title">
			<span>${content.cropTitle}</span>
		</div>
		<div class="block-separator"></div>
		<div class="content-cover-author">
			<span>
				<i class="fa fa-user"></i>
				<a class="content-author-name" data-user="${content.user.id}">${content.user.fullName}</a>
				&nbsp;<i class="fa fa-clock-o"></i>
				<g:formatDate date="${content.datePosted}" format="MM/dd" />
			</span>
		</div>
	</div>
</div>