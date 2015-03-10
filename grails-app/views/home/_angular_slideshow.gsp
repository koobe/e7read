<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
	
	<!-- Indicators -->
	<ol class="carousel-indicators">
		<li data-target="#carousel-example-generic" data-slide-to="0" ng-repeat="content in slideshowContents"></li>
	</ol>

	<!-- Wrapper for slides -->
	<div class="carousel-inner" role="listbox" >
		<div class="item" ng-class="{active: content.isFirst}" style="height: 280px; cursor: pointer;" ng-repeat="content in slideshowContents"
			ng-click="openContent(content.id);">
			<div style="
				background-position: center;
				background-repeat: no-repeat;
				background-size: cover;
				width: 100%;
				height: 100%;" ng-style="{ 'background-image': 'url(' + content.coverUrl + ')' }"></div>
			<div class="carousel-caption" style="font-size: 2em;">{{ content.cropTitle }}</div>
		</div>
		
	</div>

	<!-- Controls -->
	<a class="left carousel-control" href="#carousel-example-generic"
		role="button" data-slide="prev"> <span
		class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span
		class="sr-only">Previous</span>
	</a> <a class="right carousel-control" href="#carousel-example-generic"
		role="button" data-slide="next"> <span
		class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> <span
		class="sr-only">Next</span>
	</a>
</div>