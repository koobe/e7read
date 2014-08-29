<div class="topmenu-bar">
	<div class="">
		<ul class="topmenu-ul">
			<g:each in="${categorys}" var="category">
				<li class="topmenu-li ${active?.equals(category.name)? 'active': ''}">
					<a class="topmenu-topitem" href="?c=${category.name}"><g:message code="category.name.i18n.${category.name}" default="${category.name}" /></a>
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