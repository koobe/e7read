<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, minimal-ui" />

    <title>${content.cropTitle}</title>
    <meta name="kgl:media_count" content="3"/>
    <meta name="kgl:text_count" content="1"/>
    
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet"/>
    
     <asset:stylesheet src="default_template.css"/>
    <style>
    .tipmsg {position: relative;}
    .tipmsg::before {
        border-left: 10px solid transparent;
        border-right: 10px solid transparent;
        border-top: 10px solid #94E6DA;
        height: 0;
        width: 0;
        position: absolute;
        left: 0%;
        bottom: 90%;
        content: "";
        opacity: 0;
        margin:0 0 20px 15px;
        transition: all 0.4s ease;
    }
    .tipmsg::after {
        border-radius: 5px;
        background: #94E6DA;
        box-shadow: 1px 1px 1px 0px #ccc;
        font-size: 0.8em;
        color: #FFF;
        white-space: nowrap;
        content: attr(data-tipmsg);
        padding: 3px 10px;
        margin-bottom: 15px;
        position: absolute;
        left: 0%;
        bottom: 130%;
        opacity: 0;
        transition: all 0.4s ease;
    }
    .tipmsg:hover::before {bottom: 0%;}
    .tipmsg:hover::after {bottom: 70%;}
    .tipmsg:hover::after, .tipmsg:hover::before {opacity: 1;}
</style>
    
</head>
<body>

	<fb:init/>

	<div class="container">
	
		<div class="margin-blank"></div>
		fdfd
		
	
		<template:imageTitle content="${content}" classOfImage="bg-mask-top" classOfTitle="imagetitle-text-center" styleOfTitle="padding-bottom: 40px;" />
		
		<div class="margin-blank"></div>
		<div class="margin-blank"></div>
		<div class="margin-blank"></div>
		<div class="margin-blank"></div>
		<div class="margin-blank"></div>
		<div class="margin-blank"></div>
		<div class="margin-blank"></div>
		
		<div>
			<div class="tipmsg" data-tipmsg="可以放簡單的文字說明" style="display:inline-block; cursor:pointer;">Button</div>
		</div>
		
		
		<div class="margin-blank"></div>
		<div class="margin-blank"></div>
		<div class="margin-blank"></div>
		<div class="margin-blank"></div>
		
		<p class="tipmsg">
果利音找稱縣爸去資器首內己手處是，兩於花也不院利要被界相都會；

<a data-tipmsg="可以放簡單的文字說明" href="#">請將滑鼠移到我身上</a>

小務客想節國術助命內見究樣。</p>
		
	</div>

</body>
</html>
