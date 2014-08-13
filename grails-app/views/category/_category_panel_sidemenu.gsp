<div class="side-menu-float">
	<div class="side-menu-header">
		
		<div class="side-menu-title"><span>Category Menu</span></div>
		<div class="back-button">
			<g:link class="koobe-btn koobe-btn-normal" uri="javascript: hideCategoryMenu();" style="background-color: #8ACCC3; border: 1px solid #8ACCC3;">
		        <i class="fa fa-times-circle-o"></i>
		    </g:link>
		</div>
	</div>
	<div class="side-menu">
		<g:render template="/category/category_panel_sidemenu_item" model="[categorys: categorys]" />
	</div>
</div>