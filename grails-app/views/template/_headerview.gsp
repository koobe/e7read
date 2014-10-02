<div data-role="page" id="pageheader" class="headerview">
	<div role="main" class="ui-content">
	
		<div class="template-container">
	
			<div class="main-gallery">
		        <div class="table-row">
		            <g:each in="${content.pictureSegments}">
		                <div class="table-col" style="background-image:url(${it.thumbnailUrl? it.thumbnailUrl: it.originalUrl});" data-imageurl="${it.originalUrl}"></div>
		            </g:each>
		        </div>
		    </div>
			
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
	        
	        <br/>
	        <br/>
			
			<div style="padding: 0px 20px 0px 20px;">
				<fb:comments contentid="${content.id}"/>
			</div>
		</div>
		
	</div>
</div>