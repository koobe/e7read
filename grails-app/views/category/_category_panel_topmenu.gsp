<div class="topmenu-bar">
	<div class="hidden-xs">
		<ul class="topmenu-ul">
			<g:each in="${categorys}" var="category">
				<li class="topmenu-li">
					<a class="topmenu-topitem" href="?c=${category.name}">${category.name}</a>
					<g:if test="${category.categorys}">
						<g:render template="/category/category_panel_topmenu_item" model="[categorys: category.categorys]" />
					</g:if>
				</li>
			</g:each>
		</ul>
		
		<!-- 
		<g:each in="${categorys}" var="category">
			<div class="btn-group">
				<button type="button" class="btn btn-default" onclick="self.location.href='?c=${category.name}'">${category.name}</button>
				<g:if test="${category.categorys}">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						<span class="caret"></span>
					</button>
					<g:render template="/category/category_panel_topmenu_item" model="[categorys: category.categorys]" />
				</g:if>
			</div>
		</g:each> -->
	</div>
	<div class="open-sidemenu-btn">
		<g:link class="koobe-btn koobe-btn-normal" uri="javascript: showCategoryMenu();">
			<i class="fa fa-sitemap"></i>
		</g:link>
	</div>
</div>