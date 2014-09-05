<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	</head>
	<body>
		
		<div id="display-container">
			<g:render template="/home/header" model="[showcategorymenu: true]" />
		</div>
	
		<div class="container" style="padding-top: 40px;">
		    <div style="text-align: center;" class="alert alert-warning">
		    		<span >Oops! content has been deleted!</span>
		    </div>
		</div>
		
		<g:render template="/home/footer" />
		
		<g:include controller="category" action="addCategoryPanel" params="[btnaction: 'home']" />
		
		<script type="text/javascript">
		</script>
	</body>
</html>