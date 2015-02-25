<html>
	<head>
	    <meta name="layout" content="main"/>
	    
	    <style type="text/css">
	   		.button-group {
	   			margin-top: 30px;
	    	}
	    	
	    	.edit-button {
	    		display: inline-block;
	    	}
	    	
	    	.nav-panel {
	    		padding: 0px 0px 20px 0px;
	    	}
	    	
	    	.nav-link {
	    		display: inline-block;
	    		font-size: 1.4em;
	    		font-weight: 700;
	    	}
	    </style>
	    
	    <asset:javascript src="bookAdmin/chapter.js"/>
	</head>
	<body>
		<g:render template="/bookAdmin/header" />
		
		<div class="container-fluid">
		
			<g:render template="/bookAdmin/nav_panel" model="['displayName': (chapter?.title? chapter?.title: '新增/編輯'), 'middlePageUri': '/bookAdmin/chapterList/'+chapter?.book?.id, 'middlePageLinkName': chapter?.book?.name+' (章節管理)' ]"></g:render>
		
		    <g:form class="form-horizontal" url="[resource:chapter, action:'save']">
		    	<g:render template="/chapter/edit_form"></g:render>
		    	<g:render template="/chapter/edit_button"></g:render>
		    </g:form>
		    
		</div>
		
		<g:render template="/home/footer" />
	</body>
</html>