<div class="content-cover-block-square col-xs-{{colXs}} col-sm-{{colSm}} col-md-{{colMd}}" 
		ng-repeat="content in contents" data-contentid="{{content.id}}">
	
	<div class="block-body" ng-click="openContent(content.id)">
		<div class="div-bg-thumbnail-cover block-title-image" style="
			height: 160px;
			width: 100%;"
			ng-style="{ 'background-image': 'url(' + content.coverUrl + ')' }">
			<div class="block-image-title">
				<div class="location" style="font-size: 0.9em; font-weight: 700;">
					{{ content.distance? (content.distance | number : 2) + '公里, ' : '' }}
					{{ content.datePosted | date: 'yyyy/MM/dd' }}
				</div>
			</div>
		</div>
		<div class="block-title">
			<span>{{content.cropTitle}}</span>
		</div>
		<div class="block-separator"></div>
		<div style="padding-top: 3px;">
			<div style="display:inline-block;" class="tipmsg" data-tipmsg="在地圖中檢視">
				<span class="fa fa-map-marker" style="cursor:pointer;" ng-click="openMapInfoWindow(content.id); $event.stopPropagation();"></span>
				<span style="cursor:pointer;" ng-click="openMapInfoWindow(content.id); $event.stopPropagation();">Show</span>
			</div>
			
			<div class="content-cover-author" style="display:inline-block; float:right; padding:0;">
				<span>
					<i class="fa fa-user"></i>
					<a class="content-author-name" ng-click="showAuthor(content.user.id); $event.stopPropagation();">{{ content.user.fullName }}</a>
				</span>
			</div>
		</div>
		
	</div>
</div>