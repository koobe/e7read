<div class="content_view_ontheair">

	<div class="content_view_container">
		
		<template:containerPicturesType1 content="${content}" />
		
		<div class="title-container border-btm">
	        <div class="content-title">
	            <h1>${content.cropTitle}</h1>
	        </div>
	
	        <div style="display:table; width:100%;">
	            <div class="content-author" style="display:table-cell;">
	                <span class="author-click" data-user-id="${content.user.id}">${content.user.fullName}</span>
	            </div>
	
	            <div class="content-author" style="display:table-cell; text-align: right;">
	                <span style="font-size: 0.7em; color: #333;">
	                	<g:formatDate date="${content.datePosted}" format="yyyy/MM/dd HH:mm:ss"/>
	                </span>
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

		<template:containerTexts content="${content}" />
		
		<div class="margin-blank"></div>
		
		<div id="fb-comments">
			<fb:comments contentid="${content.id}" />
		</div>
	</div>
	
	<g:render template="/home/footer"/>
	
</div>
