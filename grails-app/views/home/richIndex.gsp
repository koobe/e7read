<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    
	    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.2/angular.js"></script>
	    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.2/angular-resource.min.js"></script>
	    
	    <script src="//soapbox.github.io/jQuery-linkify/dist/jquery.linkify.min.js"></script>
	    
	    <asset:javascript src="jquery.messagemanager.js"/>
		<asset:stylesheet src="gototop.css"/>
		<asset:javascript src="jquery.gototop.js"/>
		<asset:stylesheet src="imageview.css"/>
		<asset:javascript src="jquery.imageview.js"/>
		<asset:javascript src="image.view.msghandler.js"/>
		<asset:javascript src="jquery.hashmanager.js"/>
		<asset:javascript src="jquery.fullframe.js"/>
		<asset:javascript src="jquery.loadingspinner.js"/>
		
		<asset:javascript src="jquery.e7read.smalllogopanel.js"/>
		<asset:stylesheet src="e7read_categorystatus.css" />
		
		<asset:javascript src="e7read.contentloading.js"/>
		<asset:javascript src="content_show.js"/>
		
		<asset:javascript src="service/angular_map_service.js"/>
		<asset:javascript src="service/angular_user_service.js"/>
		<asset:javascript src="service/angular_category_service.js"/>
		<asset:javascript src="service/angular_search_service.js"/>
		
		<asset:stylesheet src="default_template.css"/>
		<asset:stylesheet src="content/content_view.css"/>
		
		<asset:javascript src="home/angular_rich_home_app.js"/>
		<asset:javascript src="home/rich_home.js"/>
		
		<asset:stylesheet src="home/category_content_panel.css"/>
		
	</head>
	<body>
	
		<fb:init/>
		
		<div id="display-container" onclick="hideCategoryMenu()" ng-app="RichHomeApp">
			
			<div class="content-pane" ng-controller="RichHomeController">
				
				<g:render template="/home/header_v2" model="[showcategorymenu: true, showsearchbar: true]" />
				
				<g:render template="angular_slideshow"></g:render>
				
				<div class="container-fliud">
					<div class="row" style="padding: 0px 20px 0px 20px;">
						<g:render template="angular_category_content_panel"></g:render>
					</div>
				</div>
				
				<g:render template="footer"></g:render>
				
	        </div>
	        
        </div>
        
        
		
		<g:include controller="category" action="addCategoryPanel" params="[btnaction: 'home', channel: params.channel]" />
		
	</body>
</html>