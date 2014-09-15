<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    
	    <asset:javascript src="jquery.messagemanager.js"/>
	    <asset:javascript src="jquery.loadingspinner.js"/>
		<asset:stylesheet src="loadingspinner.css"/>
	    <asset:stylesheet src="content_category_label.css"/>
	    <asset:stylesheet src="content_personal.css"/>
		<asset:javascript src="content_personal.js"/>
		
		<asset:stylesheet src="gototop.css"/>
		<asset:javascript src="jquery.gototop.js"/>
		<asset:stylesheet src="imageview.css"/>
		<asset:javascript src="jquery.imageview.js"/>
		<asset:javascript src="image.view.msghandler.js"/>
		<asset:javascript src="jquery.hashmanager.js"/>
		<asset:javascript src="jquery.fullframe.js"/>
		
		<asset:javascript src="content_show.js"/>
	</head>
	<body>
		<div id="display-container">
			<div class="content-pane">
				<g:render template="/home/header" model="[showsearchbar: true]" />
				<g:render template="/content/contents_container_personal" />
				<g:render template="/home/footer" />
			</div>
		</div>
		
		<script type="text/javascript">
			$('body').gototop({
				containerId: 'display-container'
			});
		</script>
	</body>
</html>