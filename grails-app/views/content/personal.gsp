<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    <asset:stylesheet src="content_personal.css"/>
		<asset:javascript src="content_personal.js"/>
		<asset:javascript src="content_show.js"/>
		<asset:stylesheet src="gototop.css"/>
		<asset:javascript src="jquery.gototop.js"/>
	</head>
	<body>
		<div id="display-container">
			<div class="content-pane">
				<g:render template="/home/header" />
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