<div class="hovercontent" style="display: table;">
	<div style="display: table-row;">
		<div style="display: table-cell; width: 35%; border-radius: 5px; background-position: center; background-repeat: no-repeat; background-size: cover; background-image:url(${it.coverUrl}); box-shadow: 0 1px 2px 1px #ccc;"></div>
		<div style="display: table-cell; width: 65%; padding-left: 15px;">
			<g:link uri="javascript: showContent('${it.id}');">
				<h4 class="media-heading text-uppercase">${it.cropTitle}</h4>
			</g:link>
			<h6><g:formatDate date="${it.dateCreated}" type="datetime" style="LONG" timeStyle="SHORT"/></h6>
			<h6>Author: ${it.user.fullName}</h6>
			<p class="text-left">${it.cropText}</p>
		</div>
	</div>
</div>