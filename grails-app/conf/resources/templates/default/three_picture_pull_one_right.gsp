<!DOCTYPE html>
<g:applyLayout name="template">
<html>
	<head>
	    <meta name="kgl:media_count" content="3"/>
	    <meta name="kgl:text_count" content="1"/>
	</head>
	<body>
	
	    <div class="template-container">
	    
	    	<div class="margin-blank"></div>
	
	        <div class="pictures-container">
	            <table class="picture-rtable">
	                <tr>
	                  <td>
	                    <div class="picture-native div-bg-thumbnail-cover" style="border: 5px solid #fff; background-image:url(${content.pictureSegments[0]?.thumbnailUrl? content.pictureSegments[0]?.thumbnailUrl: content.pictureSegments[0]?.originalUrl});" data-imageurl="${content.pictureSegments[0]?.originalUrl}"></div>
	                  </td>
	                  <td rowspan="2">
	                    <div class="picture-native div-bg-thumbnail-cover" style="border: 5px solid #fff; background-image:url(${content.pictureSegments[1]?.thumbnailUrl? content.pictureSegments[1]?.thumbnailUrl: content.pictureSegments[1]?.originalUrl});" data-imageurl="${content.pictureSegments[1]?.originalUrl}"></div>
	                  </td>
	                </tr>
	                <tr>
	                  <td>
	                    <div class="picture-native div-bg-thumbnail-cover" style="border: 5px solid #fff; background-image:url(${content.pictureSegments[2]?.thumbnailUrl? content.pictureSegments[2]?.thumbnailUrl: content.pictureSegments[2]?.originalUrl});" data-imageurl="${content.pictureSegments[2]?.originalUrl}"></div>
	                  </td>
	                </tr>
	            </table>
	        </div>
	
	        <div class="title-container border-btm">
	            <div class="content-title">
	                <h1>${content.cropTitle}</h1>
	            </div>
	            <div style="display:table; width:100%;">
	                <div class="content-author" style="display:table-cell;">
	                    <span class="author-click" data-user-id="${content.user.id}">${content.user.fullName}</span>
	                </div>
	                <div class="content-author" style="display:table-cell; text-align: right;">
	                    <span style="font-size: 0.7em; color: #333;"><g:formatDate date="${content.datePosted}" format="yyyy/MM/dd HH:mm:ss" /></span>
	                </div>
	            </div>
	        </div>
	
	        <div class="">
	            <g:if test="${content.categories}">
		        	<template:categoriesTable content="${content}" />
		        </g:if>
	            <!-- Social Toolbar -->
	            <template:socialToolbar content="${content}" />
	        </div>
	
	        <div class="margin-blank"></div>
	
	        <!-- texts of content -->
			<template:containerTexts content="${content}" />
	
	        <div class="margin-blank"></div>
	        
	        <fb:comments contentid="${content.id}"/>
	        
	    </div>
	    
	</body>
</html>
</g:applyLayout>