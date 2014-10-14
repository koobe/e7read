<!DOCTYPE html>
<g:applyLayout name="template_trade">
<html>
	<head>
	    <meta name="kgl:media_count" content="3"/>
	    <meta name="kgl:text_count" content="1"/>
	    <meta name="kgl:grouping" content="trade"/>
	</head>
	<body>

		<div class="container">
	
			<div class="margin-blank"></div>
	
			<div class="imagetitle-container">
				<div class="imagetitle-image" style="background-image:url(${content.pictureSegments[0]?.thumbnailUrl? content.pictureSegments[0]?.thumbnailUrl: content.pictureSegments[0]?.originalUrl});">
					<div class="imagetitle-text">${content.cropTitle}</div>
				</div>
			</div>
			
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
		            <div class="content-category-tags-table text-uppercase">
						<g:each in="${content.categories}" var="category">
							<div>
								<a class="content-category-name" data-categoryName="${category.name}">
									<span data-categoryName="${category.name}" class="label">
										<g:message code="category.name.i18n.${category.name}" default="${category.name}" />
									</span>
								</a>
							</div>
						</g:each>
					</div>
		        </g:if>
	
	            <!-- Social Toolbar -->
	            <template:socialToolbar content="${content}" />
		    </div>
		    
		    <div class="margin-blank"></div>
		    
		    <div class="list-group">
				<a class="list-group-item active">描述</a>
			</div>
		    
		    <div class="text-container padding-lr">
		        <div>
		            <g:each in="${content.textSegments}" var="segment">
		                <markdown:renderHtml>${segment.text}</markdown:renderHtml>
		            </g:each>
		        </div>
		    </div>
	
		    <div class="list-group">
				<a class="list-group-item active">相片集</a>
			</div>
		    
		    <div class="image-gallery">
		        <div class="image-gallery-table">
		            <g:each in="${content.pictureSegments}" var="picture">
		                <div class="image-table-cell img-thumbnail" 
							style="background-image:url(${picture.thumbnailUrl? picture.thumbnailUrl: picture.originalUrl});"
							data-imageurl="${picture.originalUrl}"></div>
		            </g:each>
		        </div>
		    </div>
		
		    <div class="margin-blank"></div>
		    
		    <div class="list-group">
				<a class="list-group-item active">地區</a>
			</div>
			<div style="width: 100%;">
		    	<img style="max-width: 100%;" src="http://maps.googleapis.com/maps/api/staticmap?center=${content.location?.lat},${content.location?.lon}&zoom=14&size=960x250&scale=2&sensor=false" alt="google map" border="0" class="img-thumbnail"/>
		    </div>
		    
		    <div class="margin-blank"></div>
		    
		    <fb:comments contentid="${content.id}" />
	    
		</div>
		
	</body>
</html>
</g:applyLayout>