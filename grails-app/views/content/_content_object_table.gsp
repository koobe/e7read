<div class="hovercontent" style="display: table;">
	<div style="display: table-row;">
		<div onclick="showContent('${it.id}');" style="display: table-cell; width: 40%; border-radius: 5px; background-position: center; background-repeat: no-repeat; background-size: cover; background-image:url(${it.coverUrl}); box-shadow: 0 1px 2px 1px #ccc; cursor: pointer;"></div>
		<div style="display: table-cell; width: 60%; padding-left: 15px;">
			<g:link uri="javascript: showContent('${it.id}');">
				<span class="text-uppercase" style="color: #787878; font-size: 20px">${it.cropTitle}</span>
			</g:link>
			<div style="border-bottom: 1px solid #94E6DA;"></div>
			<div style="text-align: right;">
				<span class="" style="color: #787878; font-size: 13px"><g:formatDate date="${it.lastUpdated}" type="date" style="LONG" />&nbsp;${it.user.fullName}</span>
			</div>
			<div style="padding-top: 7px; color: #787878;">
				<p class="text-left">${it.cropText}</p>
			</div>
		</div>
	</div>
</div>