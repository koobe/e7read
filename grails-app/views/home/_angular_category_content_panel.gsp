<div class="col-xs-12 col-sm-6 category-content-panel" ng-repeat="category in categories">
	
	<div class="category-content-panel-container" 
		ng-style="{ 'border': '1px solid ' + defaultPanelColors[category.headerBgColorIdx] }" >
	
		<div class="category-content-header" 
			ng-style="{ 'background-color' : defaultPanelColors[category.headerBgColorIdx] }">
			<a href="/home/list?c={{ category.name }}" style="color: #FFF; font-weight: 700; font-size: 1.1em;">
				<span> {{ category.displayName }} </span>
			</a>
		</div>
		
		<div class="container-fluid category-content-body">
			<g:render template="angular_category_content_panel_block"></g:render>
		</div>
		
		<div ng-style="{ 'background-color' : defaultPanelColors[category.headerBgColorIdx] }"
			style="height: 10px;"></div>
	
	</div>
</div>