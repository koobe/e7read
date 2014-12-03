<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    
	    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
	    
	    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.2/angular.js"></script>
	    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.2/angular-resource.min.js"></script>
		
		<asset:javascript src="service/angular_map_service.js"/>
		<asset:javascript src="service/angular_user_service.js"/>
		<asset:javascript src="service/angular_search_service.js"/>
		
		<asset:javascript src="jquery.messagemanager.js"/>
		<asset:stylesheet src="gototop.css"/>
		<asset:javascript src="jquery.gototop.js"/>
		<asset:stylesheet src="imageview.css"/>
		<asset:javascript src="jquery.imageview.js"/>
		<asset:javascript src="image.view.msghandler.js"/>
		<asset:javascript src="jquery.hashmanager.js"/>
		<asset:javascript src="jquery.fullframe.js"/>
		
		<asset:javascript src="e7read.contentloading.js"/>
		<asset:javascript src="content_show.js"/>
		
		<asset:javascript src="home/map_home.js"/>
		
		<asset:stylesheet src="content/content_cover_block_square.css"/>
	</head>
	<body>
		<div ng-app="MapHomeApp" ng-controller="ContentFlowController">
		
			<g:render template="header_v2" model="[showcategorymenu: true, showsearchbar: true, showChannelButton: true]" />
		
			<div class="page-container container-fluid" style="margin:0; padding:0; box-shadow: 0px -1px 3px 0px #ccc;">
			
				<div id="map-canvas" class="col-xs-5 container-map" style="height:100%; margin:0; padding:0;">
				</div>
				
				<div class="col-xs-7 container-content-flow" style="box-shadow: -2px 0px 2px 0px #ccc; height:100%; overflow-y: auto; margin:0; padding:0;" scrolling>
				
					<div class="content-pane">
						<div class="container-fluid" style="box-shadow: 1px 1px 1px 1px #ccc;">
							<H1>function block</H1>
						</div>	
						
						<div class="container-fluid">
							<g:render template="/content/content_cover_block_square_angular" />
						</div>
					</div>
				</div>
			</div>
		
			<g:render template="/home/footer" />
			
		</div>
		
		<g:include controller="channel" action="addChannelPanel" />
		<g:include controller="category" action="addCategoryPanel" params="[btnaction: 'home', channel: params.channel]" />
		
		<asset:javascript src="home/angular_map_home_app.js"/>
	</body>
</html>