<style type="text/css">
	nav {
	}

	.header {
		/*box-shadow: 0 1px 2px 1px #ccc;*/
		padding: 0px 0px 5px 0px;
	}

	.header-inline-element {
		display:inline-block; 
		vertical-align: middle;
		padding-top: 5px;
	}
	
	.search-input-fluid {
		padding: 2px 5px 2px 5px;
	}
	
	@media screen and (min-width: 769px) {
		.search-input-block {
			display: inline-block;  max-width: 150px; 
		}
		
		.search-input-fluid {
			display: none;
		}
	}
	
	@media screen and (max-width: 768px) {
		.search-input-block {
			display: none;
		}
		
		.search-input-fluid {
			display: block;
		}
	}
</style>
<nav>
	<div class="header" style="">
		<div class="header-inline-element">
			<a href="javascript:showChannelMenu();" style="font-size: 1.1em;" class="koobe-btn koobe-btn-normal">
				<i class="fa fa-bars"></i>
			</a>
		</div>
		
		<div class="header-inline-element" >
			<g:link url="/${channel.name}" style="text-decoration: none !important;" target="_top">
				<g:img uri="${channel.logoImg}" style="height: 30px;"/>
			</g:link>
		</div>
		
		<g:if test="${showcategorymenu}">
			<div class="header-inline-element" style="vertical-align: bottom;">
				<g:render template="/category/category_panel" />
			</div>
		</g:if>
		
		<div class="header-inline-element" style="float:right;">
			<g:if test="${showsearchbar}">
				<div class="search-input-block">
		        	<div class="input-group" style="height: 20px;">
		        		<span class="input-group-addon koobe-bg-color">
					        <i class="fa fa-search"></i>
					    </span>
					    <input type="text" class="form-control" ng-keypress="search($event);" />
				    </div>
				</div>
			</g:if>
				
			<div class="" style="display:inline-block;">
				<g:render template="/home/usermenu" />
			</div>
		</div>
		
		<div class="" style="clear: both;"></div>
		
		<g:if test="${showsearchbar}">
			<div class="search-input-fluid">
	        	<div class="input-group">
	        		<span class="input-group-addon koobe-bg-color">
				        <i class="fa fa-search"></i>
				    </span>
				    <input type="text" class="form-control" ng-keypress="search($event);" />
			    </div>
			</div>
		</g:if>
	</div>
	
</nav>