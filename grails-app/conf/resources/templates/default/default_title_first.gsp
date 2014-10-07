<!DOCTYPE html>
<g:applyLayout name="${layout}">
<html>
	<head>
	    <meta name="kgl:media_count" content="3"/>
	    <meta name="kgl:text_count" content="1"/>
	</head>
	<body data-linkify="p, .plain-text" id="content-body">
	
	    <div class="template-container">
		
			<div class="title-container border-btm margin-lr-20">
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
	
	        <div class="margin-lr-20">
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
		    
		    <div class="main-gallery">
		        <div class="table-row">
		            <g:each in="${content.pictureSegments}">
		                <div class="table-col" style="background-image:url(${it.thumbnailUrl? it.thumbnailUrl: it.originalUrl});" data-imageurl="${it.originalUrl}"></div>
		            </g:each>
		        </div>
		    </div>
			
			<div class="margin-blank"></div>
			
		    <div class="text-container padding-lr">
		        <div>
		        	<g:each in="${content.textSegments}" var="segment">
		                <markdown:renderHtml>${segment.text}</markdown:renderHtml>
		            </g:each>
		        </div>
		    </div>
		    
		    <div class="margin-blank"></div>
		    
		    <fb:comments contentid="${content.id}"/>
		</div>
	</body>
</html>
</g:applyLayout>