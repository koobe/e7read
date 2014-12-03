<script type="text/javascript">
<!--
	function openContentMap(contentId) {
		window.open("/map/content/" + contentId, "_blank");
	}
//-->
</script>
<div class="container" style="margin: 0; padding: 0;">
	<div class="col-xs-12 col-sm-6" style="margin: 0; padding: 0;">
		<div class="div-bg-thumbnail-cover imagetitle-align-image" style="
				background-image:url(${content.pictureSegments[0]?.originalUrl});
				">
				
				<div class="imagetitle-block">
					<div class="imagetitle-text ${classOfTitle}" style="${styleOfTitle}">
						<a href="/share/${content.id}" target="_blank">${content.cropTitle}</a>
					</div>
					<div class="imagetitle-date ${classOfDate}" style="${styleOfDate}">
						
						<g:if test="${content.location}">
							${content.location?.getLocationName()},
						</g:if>
						<g:formatDate date="${content.datePosted}" format="yyyy/MM/dd"/>
					</div>
				</div>
		</div>
	</div>
	<div class="col-xs-12 col-sm-6" style="margin: 0; padding: 0;">
		<div class="div-bg-thumbnail-cover imagetitle-align-image" style="
			cursor: pointer;
			background-image:url(http://maps.googleapis.com/maps/api/staticmap?center=${content.location?.lat},${content.location?.lon}&zoom=14&size=960x250&scale=2&sensor=false&markers=color:blue%7Clabel:H%7C${content.location?.lat},${content.location?.lon});
		" onclick="openContentMap('${content.id}')"></div>
	</div>
</div>
