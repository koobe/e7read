<div class="hovercontent" style="display: table;">
	<div style="display: table-row;">
		<div onclick="showContent('${it.id}');" style="display: table-cell; width: 40%; border-radius: 5px; background-position: center; background-repeat: no-repeat; background-size: cover; background-image:url(${it.coverUrl}); box-shadow: 0 1px 2px 1px #ccc; cursor: pointer;"></div>
		<div style="display: table-cell; width: 60%; padding-left: 15px;">
			<g:link uri="javascript: showContent('${it.id}');">
				<h4 class="text-uppercase" style="color: #787878 ">${it.cropTitle}</h4>
			</g:link>
			<div style="border-bottom: 1px solid #94E6DA;"></div>
			<h6 style="text-align: right;"><g:formatDate date="${it.lastUpdated}" type="date" style="LONG" />&nbsp;${it.user.fullName}</h6>
			<p class="text-left">${it.cropText}</p>
		</div>
	</div>
</div>