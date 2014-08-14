<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    <asset:javascript src="content_show.js"/>
	</head>
	<body>
		<div id="display-container" onclick="hideCategoryMenu()"><div class="content-pane">
			<g:render template="header" />
			<g:render template="/category/category_panel" />
			<g:render template="/content/contents_container" />
			<g:render template="footer" />
        </div></div>
		
		<g:include controller="category" action="addCategoryPanel" />
		
		<a href="javascript: scrollDisplayContainerToTop();" class="koobe-btn koobe-btn-normal top-btn-pos">
			<i class="fa fa-caret-up"></i>
		</a>
	</body>
</html>