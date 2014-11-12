<div class="content-cover-block-square col-xs-12 col-sm-4 col-md-3" ng-repeat="content in contents">
	<div class="block-body" ng-click="openContent(content.id)">
		<div class="div-bg-thumbnail-cover block-title-image" style="
			background-image:url({{ content.coverUrl }});
			height: 170px;
			width: 100%;
		">
			<div class="block-image-title">
				<div class="title">{{ content.cropTitle }}</div>
				<div class="location">
					{{ content.distance? (content.distance | number : 2) + '公里, ' : '' }}
					{{ content.datePosted | date: 'yyyy/MM/dd' }}
				</div>
			</div>
		</div>
		<div class="block-title">
			<span>{{content.cropTitle}}</span>
		</div>
		<div class="block-separator"></div>
		<div class="content-cover-author">
			<span>
				<i class="fa fa-user"></i>
				<a class="content-author-name" ng-click="showAuthor(content.user.id); $event.stopPropagation();">{{ content.user.fullName }}</a>
				&nbsp;<i class="fa fa-clock-o"></i>
				{{ content.datePosted | date: 'MM/dd' }}
			</span>
		</div>
	</div>
</div>