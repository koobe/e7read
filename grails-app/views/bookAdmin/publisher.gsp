<html>
	<head>
	    <meta name="layout" content="main"/>
	    
	    <style type="text/css">
	   		
	   		.button-group {
	   			
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
		
		    <g:form class="form-horizontal" url="[resource:publisher, action:'save']">
		    	<g:render template="/publisher/edit_button"></g:render>
		    	<g:render template="/publisher/edit_form"></g:render>
		    </g:form>
		    
		</div>
		
		<g:render template="/home/footer" />
	</body>
</html>