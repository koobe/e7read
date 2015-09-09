<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    
	    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.2/angular.js"></script>
	    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.2/angular-resource.min.js"></script>
	    
	    <asset:javascript src="jquery.linkify.min.js"/>
	    
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
		<asset:javascript src="service/angular_search_service.js"/>
		
		<asset:stylesheet src="default_template.css"/>
		<asset:stylesheet src="content/content_view.css"/>
		
	</head>
	<body>
	
		<fb:init/>
		
		<div id="display-container" onclick="hideCategoryMenu()" ${(channel.themeType == 'square')? 'ng-app=coverFlowApp scrolling': ''}>
			<div class="content-pane" ${(channel.themeType == 'square')? 'ng-controller=CoverFlowController': ''}>
				
				<g:render template="/home/header_v2" model="[showcategorymenu: true, showsearchbar: true, showChannelButton: true]" />
				
				<g:if test="${showSetLocationTip}">
					<div class="container">
			        	<div style="
				        	display: inline-block;
				        	background-color: rgba(148, 230, 218, 0.5);
				        	border-radius: 4px;
				        	padding: 2px 10px 2px 10px;
				        	font-size: 0.9em;
				        	color: #555;
				        	float:right;">
			        		您尚未設定個人位置，請<a href="/map/welcome">設定</a>。
			        	</div>
		        	</div>
		        </g:if>
				
				<g:if test="${(channel.themeType == 'square')}">
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
		
		<script type="text/javascript">
			$('body').gototop({
				containerId: 'display-container',
				z_index: 300
			});
		</script>
		
		
	</body>
</html>