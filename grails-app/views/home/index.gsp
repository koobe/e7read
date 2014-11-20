<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    
	    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.2/angular.min.js"></script>
	    <script src="//code.angularjs.org/1.3.2/angular-resource.min.js"></script>
	    
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
		
		<g:if test="${params.channel != 'trade'}">
			<asset:javascript src="e7read.geolocation.js"/>
		</g:if>
	</head>
	<body>
		
		<div id="display-container" onclick="hideCategoryMenu()" 
			${params.channel=='trade'? 'ng-app=coverFlowApp scrolling': ''}>
			<div class="content-pane">
				
				<g:render template="header" model="[showcategorymenu: true, showsearchbar: true, showChannelButton: true]" />
				
				<g:if test="${params.channel == 'trade'}">
					<g:render template="/content/content_coverflow_container"></g:render>
				</g:if>
				<g:else>
					<g:render template="/content/contents_container" />
				</g:else>
				
				<g:render template="footer" />
				
	        </div>
        </div>
		
		<g:include controller="category" action="addCategoryPanel" params="[btnaction: 'home', channel: params.channel]" />
		
		<g:include controller="channel" action="addChannelPanel" params="" />
		
		<g:render template="/category/category_status_panel" />
		
		<script type="text/javascript">
			$('body').gototop({
				containerId: 'display-container',
				z_index: 300
			});
		</script>
	</body>
</html>