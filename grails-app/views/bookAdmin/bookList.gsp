<html>
	<head>
	    <meta name="layout" content="main"/>
	    
	    <script type="text/javascript">
	    	$(function() {
	    		$('.book-list').addClass('active');
			});
	    </script>
	    
	    <asset:javascript src="bookAdmin/search.js"/>
	    <asset:javascript src="bookAdmin/book_list_table.js"/>
	</head>
	<body>
		<g:render template="/bookAdmin/header" />
		
		<g:render template="/bookAdmin/booklist_table" />
		
		<div style="text-align: center;">
			<g:paginate next="&raquo;" prev="&laquo;" total="${bookCount}" params="${params}" />
		</div>
		
		<g:render template="/home/footer" />
	</body>
</html>