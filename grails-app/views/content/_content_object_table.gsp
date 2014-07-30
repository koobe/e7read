<div class="hovercontent" style="display: table; cursor: pointer;" onclick="showContent('${it.id}');">
	<div style="display: table-row;">
		<div style="display: table-cell; width: 40%; border-radius: 5px; background-position: center; background-repeat: no-repeat; background-size: cover; background-image:url(${it.coverUrl}); box-shadow: 0 1px 2px 1px #ccc; "></div>
		<div style="display: table-cell; width: 60%; padding-left: 15px;">
			
			<strong><span class="text-uppercase content-title" style="line-height: 150%; color: #333; font-size: 20px; -webkit-font-smoothing: antialiased;">${it.cropTitle}</span></strong>
			
			<div style="border-bottom: 1px solid #94E6DA;"></div>
			<div style="text-align: right;">
				<span class="" style="color: #333; font-size: 13px"><g:formatDate date="${it.lastUpdated}" type="date" style="LONG" />&nbsp;${it.user.fullName}</span>
			</div>
			<div style="padding-top: 13px; color: #333;">
				<p class="text-left" style="-webkit-font-smoothing: antialiased; line-height: 160%; letter-spacing: 1px;">${it.cropText}</p>
			</div>
		</div>
	</div>
</div>