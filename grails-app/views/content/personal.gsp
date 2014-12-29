<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    
	    <script src="//soapbox.github.io/jQuery-linkify/dist/jquery.linkify.min.js"></script>
	    
	    <asset:javascript src="jquery.messagemanager.js"/>
	    <asset:javascript src="jquery.loadingspinner.js"/>
		<asset:stylesheet src="loadingspinner.css"/>
	    <asset:stylesheet src="content_category_label.css"/>
	    <asset:stylesheet src="content_personal.css"/>
		
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
		<asset:javascript src="content_personal.js"/>
		<asset:javascript src="content_show.js"/>
		
		<asset:stylesheet src="default_template.css"/>
		<asset:stylesheet src="content/content_view.css"/>
	</head>
	<body>
		<fb:init/>
	
		<div id="display-container">
			<div class="content-pane">
				<g:render template="/home/header_v2" model="[showsearchbar: false]" />
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