<div class="topmenu-bar">
	<div class="">
		<ul class="topmenu-ul">
			<g:each in="${categorys}" var="category">
				<li class="topmenu-li ${active?.equals(category.name)? 'active': ''}">
                    <g:link controller="home" action="index" params="${[c: category.name]}" class="topmenu-topitem">
                        <g:message code="category|${category.name}" default="${category.name}" />
                    </g:link>
					<g:if test="${category.categorys}">
						<g:render template="/category/category_panel_topmenu_item" model="[categorys: category.categorys]" />
					</g:if>
				</li>
			</g:each>
		</ul>
	</div>
	
	<div>
		<a href="javascript: showCategoryMenu();">
			<g:img class="sidemenu-btn-img" uri="/assets/arrow.png"/>
		</a>
	</div><!-- 
	<div class="open-sidemenu-btn">
		<g:link class="koobe-btn koobe-btn-normal" uri="javascript: showCategoryMenu();">
			<i class="fa fa-sitemap"></i>
		</g:link>
		<a href="javascript: showCategoryMenu();">
			<g:img class="sidemenu-btn-img" uri="/assets/arrow.png"/>
		</a>
	</div>
	 -->
</div>