<div class="koobe-header">
	<div class="header-logo">
		<g:link url="/${channel.name}" style="text-decoration: none !important;" target="_top">
			<!-- <span class="glyphicon glyphicon-book logomark"></span>
			<span style="color: #d9534f;">E</span><span style="color: #5cb85c;">7</span><span style="color: #1A0B79;">R</span><span style="color: #5bc0de;">E</span><span style="color: #5cb85c;">A</span><span style="color: #F7B81B;">D</span>
			<span style="vertical-align: super; font-size: 0.5em;">beta</span> -->
			
			
			<g:if test="${channel.logoImg}">
				<g:img class="img-logo" uri="${channel.logoImg}" />
			</g:if>
			<g:else>
				<span class="text-uppercase logotitle">${channel.name}</span>
			</g:else>
		</g:link>
	</div>
	<g:if test="${showcategorymenu}">
		<div class="header-cate-menu">
			<g:render template="/category/category_panel" />
		</div>
	</g:if>
	
	<!-- 
	<div class="header-search-usermenu">
		<div class="display-table">
		 -->
		 	<g:if test="${showsearchbar}">
				<div class="header-search">
			        <g:form uri="" role="search" class="" method="get">
			        	<div class="input-group">
			        	<span class="input-group-addon koobe-bg-color">
						        <i class="fa fa-search"></i>
						    </span>
						    <g:textField id="text-search" name="q" class="form-control input-search" value="${params.q? params.q: ''}"/>
						    
					    </div>
					    <!--<g:hiddenField name="from" value="0" />
						<g:hiddenField name="size" value="5" />-->
					</g:form>
				</div>
			</g:if>
			<div class="header-usermenu">
				<g:render template="/home/usermenu" />
			</div>
			<!-- 
		</div>
	</div> -->
</div>