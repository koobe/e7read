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
	    
	</head>
	<body>
		<g:render template="/bookAdmin/header" />
		
		<div class="container-fluid">
		
			<g:render template="/bookAdmin/nav_panel" model="['displayName': book.name + ' (分配)']"></g:render>
			
			<g:form class="form-horizontal" url="[controller:'content', action:'distributeBookContent']" method="PUT">
		    	<g:render template="/bookAdmin/distribute_edit_button"></g:render>
		    	<g:render template="/bookAdmin/distribute_edit_form"></g:render>
		    </g:form>
		    
		    <div style="font-size: 1.2em; font-weight: 700; padding-bottom: 10px;">
		    	此書已分配列表：
		    </div>
		    
		    <g:render template="contentlist_table"></g:render>
		    
		</div>
		
		<g:render template="/home/footer" />
	</body>
</html>