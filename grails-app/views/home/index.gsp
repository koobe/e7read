<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    <asset:javascript src="jquery.messagemanager.js"/>
	    <asset:javascript src="jquery.loadingspinner.js"/>
		<asset:stylesheet src="loadingspinner.css"/>
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
		<div id="display-container" onclick="hideCategoryMenu()"><div class="content-pane">
			<g:render template="header" model="[showcategorymenu: true, showsearchbar: true]" />
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