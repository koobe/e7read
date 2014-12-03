<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    
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
		
		
	</head>
	<body>
		<g:render template="header_v2" model="[showcategorymenu: true, showsearchbar: true, showChannelButton: true]" />
		
		<g:include controller="channel" action="addChannelPanel" params="" />
		<g:include controller="category" action="addCategoryPanel" params="[btnaction: 'home', channel: params.channel]" />
	</body>
</html>