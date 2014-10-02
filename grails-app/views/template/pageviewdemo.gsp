<html>
	<head>
	    <title></title>
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    
	    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	    
	    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.4/jquery.mobile-1.4.4.min.css" />
		<script src="//code.jquery.com/mobile/1.4.4/jquery.mobile-1.4.4.min.js"></script>
		
		<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
		
		<script src="//soapbox.github.io/jQuery-linkify/dist/jquery.linkify.min.js"></script>
		
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"/>
		
		<asset:stylesheet src="imageview.css"/>
		<asset:javascript src="jquery.imageview.js"/>
	
		<asset:stylesheet src="gototop.css"/>
		<asset:javascript src="jquery.gototop.js"/>
		<asset:stylesheet src="e7read_categorystatus.css" />
		<asset:javascript src="jquery.e7read.categorystatus.js"/>
		
		<asset:stylesheet src="pageviewdemo.css" />
		<asset:javascript src="default_template.js" />
		<script src="/assets/pageviewdemo.js"></script>
	</head>
	<body>
		<fb:init/>
		<template:contentHeaderView content="${content}" />
		<template:contentParagraphView content="${content}" />
	</body>
</html>