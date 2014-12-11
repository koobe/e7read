<style type="text/css">

	.header-inline-element {
		display:inline-block; 
		vertical-align: middle;
		padding-top: 5px;
	}
	
	.search-input-fluid {
		padding: 2px 0px 0px 5px;
	}
	
	.header-usermenu {
		display:inline-block;
	}
	
	@media screen and (min-width: 769px) {
		.header {
			/*box-shadow: 0 1px 2px 1px #ccc;*/
			padding: 0px 0px 2px 0px;
		}
		
		.header-image {
			height: 30px;
		}
	
		.search-input-block {
			display: inline-block;  max-width: 150px; 
		}
		
		.search-input-fluid {
			display: none;
		}
		
		.menu-expend-button {
			display: none;
		}
	}
	
	@media screen and (max-width: 768px) {
		.header {
			/*box-shadow: 0 1px 2px 1px #ccc;*/
			padding: 0px 0px 4px 0px;
		}
		
		.header-image {
			height: 26px;
		}
	
		.search-input-block {
			display: none;
		}
		
		.search-input-fluid {
			display: block;
		}
		
		.menu-expend-button {
			display: inline-block;
		}
	}
</style>

<asset:javascript src="home/header_control.js"/>

<nav>
	<div class="header" style="">
		<div class="header-inline-element">
			<a href="javascript:showChannelMenu();" style="font-size: 1.1em;" class="koobe-btn koobe-btn-normal">
				<i class="fa fa-bars"></i>
			</a>
		</div>
		
		<div class="header-inline-element" >
			<g:link url="/${channel.name}" style="text-decoration: none !important;" target="_top">
				<g:img uri="${channel.logoImg}" class="header-image"/>
			</g:link>
		</div>
		
		<g:if test="${showcategorymenu}">
			<div class="hidden-xs hidden-min header-inline-element" style="vertical-align: bottom;">
				<g:render template="/category/category_panel" />
			</div>
		</g:if>
		
		<div class="header-inline-element" style="float:right;">
			
			<div class="menu-expend-button">
				<a href="#" style="font-size: 1.1em;" class="koobe-btn koobe-btn-normal">
					<i class="fa fa-caret-down"></i>
				</a>
			</div>
		
			<g:if test="${showsearchbar}">
				<div class="hidden-xs hidden-min search-input-block">
		        	<div class="input-group" style="height: 20px;">
		        		<span class="input-group-addon koobe-bg-color">
					        <i class="fa fa-search"></i>
					    </span>
					    <input type="text" class="form-control fulltext-searchbox" ng-keypress="search($event);" />
				    </div>
				</div>
			</g:if>
				
			<div class="hidden-xs hidden-min header-usermenu" style="">
				<g:render template="/home/usermenu" />
			</div>
		</div>
		
		<div class="" style="clear: both;"></div>
		
		<g:if test="${showsearchbar}">
			<div class="hidden-xs hidden-min search-input-fluid">
				
				<div style="display:inline-block; width: 85%;">
					<div class="input-group">
	        			<span class="input-group-addon koobe-bg-color" style="height:25px; padding: 3px 15px;">
					        <i class="fa fa-search"></i>
					    </span>
					    <input type="text" class="form-control fulltext-searchbox" style="height:25px;" ng-keypress="search($event);" />
				    </div>
				</div>
	        	
			    <div class="menu-hide-button" style="display:inline-block; float:right;">
					<a href="#" style="font-size: 1.1em;" class="koobe-btn koobe-btn-normal">
						<i class="fa fa-caret-up"></i>
					</a>
				</div>
			</div>
		</g:if>
	</div>
	
</nav>