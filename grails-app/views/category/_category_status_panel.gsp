<g:if test="${params.c}">
	<asset:stylesheet src="category_status_panel.css" />
	<asset:javascript src="category_status_panel.js" />
	
	<div class="category-status-panel">
		<div>
			<a href="/${params.channel}">
				<!-- <span class="category-status-logo">E7READ.com,</span>  -->
				<img src="/assets/trans_logo_${params.channel}.png" class="category-status-logo">
			</a>
		</div>
		<div class="category-status-indicator">
			<span class="">&nbsp;<g:message code="category.currentat" default="current at" />:</span>
			<span class="category-status-category-name"><g:message code="category|${params.c}" default="${params.c}" /></span>
		</div>
		
		<div>
			<a href="javascript: showCategoryMenu();">
				<img src="/assets/grey_arrow.png" class="category-status-catebtn">
			</a>
		</div>
	</div>
</g:if>