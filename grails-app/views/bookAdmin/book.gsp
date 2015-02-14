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
	    
	    <asset:javascript src="bookAdmin/book.js"/>
	</head>
	<body>
		<g:render template="/bookAdmin/header" />
		
		<div class="container-fluid">
		
			<div class="nav-panel">
				<g:if test="${session?.bookAdminNavigation?.prevAction}">
					<div class="nav-link">
						<g:link controller="bookAdmin" action="${session?.bookAdminNavigation?.prevAction}" 
							params="${session?.bookAdminNavigation?.params}">
							<g:if test="${session?.bookAdminNavigation?.prevAction == 'newBookList'}">
								新書
							</g:if>
							<g:if test="${session?.bookAdminNavigation?.prevAction == 'bookList'}">
								電子書
							</g:if>
						</g:link>
					</div>
					<div class="nav-link"> &gt; </div>
				</g:if>
				<div class="nav-link">${book?.name}</div>
			</div>
			
			<div class="container">
				<g:if test="${success}">
					<div class="alert alert-success">儲存成功</div>
				</g:if>
				<g:hasErrors bean="${book}">
		            <g:eachError bean="${book}" var="error">
		            	<div class="alert alert-danger"><g:message error="${error}"/></div>
		            </g:eachError>
		        </g:hasErrors>
	        </div>
		
		    <g:form class="form-horizontal" url="[action:'update', controller:'bookAdmin', resource:book]" method="PUT">
		    	<g:render template="/book/edit_form"></g:render>
		    	<g:render template="/bookAdmin/edit_button"></g:render>
		    </g:form>
		    
		</div>
		
		<g:render template="/home/footer" />
	</body>
</html>