<html>
	<head>
	    <meta name="layout" content="main"/>
	    
	    <style type="text/css">
	    		    	
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
	    
	    <asset:javascript src="bookAdmin/chapter_list_table.js"/>
	</head>
	<body>
		<g:render template="/bookAdmin/header" />
		
		<div class="container-fluid">
		
			<g:render template="/bookAdmin/nav_panel" model="['displayName': book?.name, 'appendDisplayName': '章節管理']"></g:render>
			
			<g:render template="/bookAdmin/chapterlist_function_button"></g:render>
			
			<g:render template="/bookAdmin/chapterlist_table"></g:render>
		    
		</div>
		
		<g:render template="/home/footer" />
	</body>
</html>