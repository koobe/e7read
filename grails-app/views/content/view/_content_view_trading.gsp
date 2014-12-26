<div class="content_view_ontheair">

	<div class="content_view_container">
		
		<template:imageMapTitle content="${content}" />
			
		<div class="margin-blank"></div>
		
		<div class="border-btm">
			<div style="display:table; width:100%;">
			    <div class="content-author" style="display:table-cell;">
			        <span class="author-click" data-user-id="${content.user.id}">${content.user.fullName}</span>
			    </div>
			
			    <div class="content-author" style="display:table-cell; text-align: right;">
			        <span style="font-size: 0.7em; color: #333;"><g:formatDate date="${content.datePosted}" format="yyyy/MM/dd HH:mm:ss"/></span>
			    </div>
			</div>
		</div>
		
		<div class="">
	        <g:if test="${content.categories}">
	        	<template:categoriesTable content="${content}" />
	        </g:if>
            <template:socialToolbar content="${content}" />
	    </div>
	    
	    <div class="margin-blank"></div>
	    
	    <!-- texts of content -->
		<template:containerTexts content="${content}" />
	    
	    <template:sectionTitle title="相片" />
	    
	    <template:containerPicturesType1 content="${content}" />
	    
	    <div class="margin-blank"></div>
	    
	    <div style="text-align: center;">
	    	<g:link class="btn btn-default btn-contact-me" target="_blank"
	    	uri="/message/conversation?contentId=${content.id}">跟我聯絡</g:link>
	    </div>
	    
	    <div class="margin-blank"></div>
		
		<div id="fb-comments">
			<fb:comments contentid="${content.id}" />
		</div>
	</div>
	
	<g:render template="/home/footer"/>
	
</div>
