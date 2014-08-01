<div class="hovercontent" style="display: table; cursor: pointer; width:100%; height:20em;" onclick="showContent('${it.id}');">
	<div style="display: table-row;">
		<div style="display: table-cell; width: 40%; border-radius: 5px; background-position: center; background-repeat: no-repeat; background-size: cover; background-image:url(${it.coverUrl}); box-shadow: 0 1px 2px 1px #ccc; "></div>
		<div style="display: table-cell; width: 60%; padding-left: 15px;">
			
			<strong><span class="text-uppercase content-title" style="line-height: 150%; color: #333; font-size: 20px; -webkit-font-smoothing: antialiased;">${it.cropTitle}</span></strong>
			
			<div style="border-bottom: 1px solid #94E6DA;"></div>
			<div style="text-align: right;">
				<span class="" style="color: #333; font-size: 13px">
				<i class="fa fa-user"></i>
				${it.user.fullName}
				&nbsp;<i class="fa fa-clock-o"></i>
				<g:formatDate date="${it.lastUpdated}" format="MM/dd" />
				</span>
			</div>
			<div class="contentlist-text" style="padding-top: 1.8em; color: #333; max-height: 12.6em; min-height: 12.6em; min-width:100%; overflow: hidden;">
				<p class="text-left" style="-webkit-font-smoothing: antialiased; line-height: 1.8em;  letter-spacing: 1px; text-overflow: ellipsis;display: -webkit-box;-webkit-line-clamp: 6;-webkit-box-orient: vertical;">${it.cropText}</p>
			</div>
		</div>
	</div>
</div>