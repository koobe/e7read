<div class="imagetitle-container">
	<div class="imagetitle-image div-bg-thumbnail-cover ${classOfImage}" 
			style="background-image:url(${content.pictureSegments[0]?.thumbnailUrl? content.pictureSegments[0]?.thumbnailUrl: content.pictureSegments[0]?.originalUrl});">
		
		<div class="imagetitle-block">
			<div class="imagetitle-text ${classOfTitle}" style="${styleOfTitle}">
				<a href="/share/${content.id}" target="_blank">${content.cropTitle}</a>
			</div>
			<g:if test="${showDate.equals('true')}" >
				<div class="imagetitle-date ${classOfDate}" style="${styleOfDate}">
					
					<g:if test="${content.location}">
						${content.location?.getLocationName()},
					</g:if>
				
					<g:formatDate date="${content.datePosted}" format="yyyy/MM/dd"/>
				</div>
			</g:if>
		</div>
	</div>
</div>