<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    <asset:javascript src="jquery.loadingspinner.js"/>
		<asset:stylesheet src="loadingspinner.css"/>
		<asset:stylesheet src="gototop.css"/>
		<asset:javascript src="jquery.gototop.js"/>
	</head>
	<body>
		<div id="display-container" onclick="hideCategoryMenu()"><div class="content-pane">
			<g:render template="header" model="[showcategorymenu: true]" />
			<g:render template="/content/contents_container" />
			<g:render template="footer" />
        </div></div>
		
		<g:include controller="category" action="addCategoryPanel" params="[btnaction: 'home']" />
		
		<g:render template="/category/category_status_panel" />
		
		<!-- 
		<a href="javascript: scrollDisplayContainerToTop();" class="koobe-btn koobe-btn-normal top-btn-pos">
			<i class="fa fa-caret-up"></i>
		</a> -->
		
		<script type="text/javascript">
			$('body').gototop({
				containerId: 'display-container',
				z_index: 300
			});
		</script>
	</body>
</html>