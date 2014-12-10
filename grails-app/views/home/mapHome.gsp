<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    
	    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
	    
	    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.2/angular.js"></script>
	    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.2/angular-resource.min.js"></script>
		
		<asset:javascript src="service/angular_map_service.js"/>
		<asset:javascript src="service/angular_user_service.js"/>
		<asset:javascript src="service/angular_search_service.js"/>
		<asset:javascript src="service/angular_googlemap_service.js"/>
		
		<asset:javascript src="jquery.messagemanager.js"/>
		<asset:stylesheet src="gototop.css"/>
		<asset:javascript src="jquery.gototop.js"/>
		<asset:stylesheet src="imageview.css"/>
		<asset:javascript src="jquery.imageview.js"/>
		<asset:javascript src="image.view.msghandler.js"/>
		<asset:javascript src="jquery.hashmanager.js"/>
		<asset:javascript src="jquery.fullframe.js"/>
		
		<asset:javascript src="e7read.contentloading.js"/>
		<asset:javascript src="content_show.js"/>
		
		<asset:javascript src="home/map_home.js"/>
		
		<asset:stylesheet src="content/content_cover_block_square.css"/>
		
		<style type="text/css">
		
			.controls {
		       
		        border: 1px solid transparent;
		        border-radius: 2px 0 0 2px;
		        box-sizing: border-box;
		        -moz-box-sizing: border-box;
		        height: 27px;
		        outline: none;
		        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
		      }
		      
		      #pac-input {
		        background-color: #fff;
		        padding: 0 6px 0 6px;
				
				margin-top: 7px;
		        margin-left: -1px;
		        
		        width: 60%;
		        font-size: 15px;
		        font-weight: 300;
		        text-overflow: ellipsis;
		      }
		      
		      .info-window-image {
		      	width: 120px;
		      	height: 120px;
		      }
		      
		      .info-window-title {
		      	overflow: hidden;
				white-space: nowrap;
				text-overflow: ellipsis;
				padding: 7px 0px 0px 0px;
				font-weight: 700;
		      }
		      
		      .info-window-info {
				padding-top: 3px;
				font-size: 0.9em;
		      }
		      
		      .info-window-separator {
		      	border-top: 1px solid #94E6DA;
		      	padding-bottom: 4px;
		      }
		      
		      .control-position {
		      		font-size: 1.3em;
					color: #666;
					cursor: pointer;
					background-color: #fff;
					padding: 3px 9px 3px 9px;					
					right: 9px !important;
					box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
					margin: 4px 0px 4px 0px;
		      }
		
		</style>
	</head>
	<body>
		<div ng-app="MapHomeApp" ng-controller="ContentFlowController">
		
			<g:render template="header_v2" model="[showcategorymenu: true, showsearchbar: true, showChannelButton: true]" />
		
			<div class="page-container container-fluid" style="margin:0; padding:0; box-shadow: 0px -1px 3px 0px #ccc;">
				
				<div id="map-canvas" class="col-xs-5 container-map" style="height:100%; margin:0; padding:0;">
				</div>
				
				<!-- map controls -->
				<input id="pac-input" class="controls" type="text" />
				
				<sec:ifLoggedIn>
					<i id="get-my" class="fa fa-user control-position" ng-click="returnMyLocation()"></i>
				</sec:ifLoggedIn>
				<i id="get-current" class="fa fa-crosshairs control-position" ng-click="setLocationBySensor()"></i>
				
				<i id="full-map" class="fa fa-search-plus control-position" ng-click="setFullMap()"></i>
				<i id="half-map" class="fa fa-search-minus control-position" style="display:none;" ng-click="setHalfMap()"></i>
				
				<div id="is-search" class="checkbox control-position" style="width: 110px; font-size: 1.2em; margin-top: 7px;">
				    <label>
				      <input type="checkbox" ng-checked="isMapSearch" ng-model="isMapSearch" />移動時搜尋
				    </label>
				  </div>
				<!-- map controls -->
				
				<div id="content-canvas" class="col-xs-7 container-content-flow" style="box-shadow: -2px 0px 2px 0px #ccc; height:100%; overflow-y: auto; margin:0; padding:0;" scrolling>
				
					<div class="content-pane">
						<div class="container-fluid" style="padding:0px 10px 5px 10px;">
						
							<div style="display:inline-block; vertical-align: middle; margin-top: 10px;">
								<div style="display:inline-block; padding-right: 5px;" ng-if="category">
									<span>類別：</span>
									<span class="btn btn-default" style="
										padding-top: 1px;
										padding-bottom: 1px;
										border-radius: 12px;
										margin-left: -3px;
									">{{ categoryName }}</span>
								</div>
							</div>
							
							<div style="display:inline-block; float:right; vertical-align: middle; margin-top: 10px;">
								
								<div style="display:inline-block; padding-right: 10px;" ng-if="keyword">
									<span>搜尋：</span>
									<span ng-click="removeKeyword();" class="btn btn-default" style="
										padding-top: 1px;
										padding-bottom: 1px;
										border-radius: 12px;
									">{{ keyword }} <i class="fa fa-times"></i></span>
								</div>
								<div style="display:inline-block;">
									<span>排序：</span>
									<div class="btn-group" data-toggle="buttons" >
							            <label id="btnSortByDistance" class="btn btn-default active" style="padding: 2px 11px 2px 11px;" ng-click="orderByNear()">
							                <input type="radio" name="sorting" id="sortByDistance" value="true" autocomplete="off" checked>
							                距離
							            </label>
							            <label id="btnSortByNewest" class="btn btn-default" style="padding: 2px 11px 2px 11px;" ng-click="orderByDate()">
							                <input type="radio" name="sorting" id="sortByNewest" value="false" autocomplete="off" >
							                最新
							            </label>
							        </div>
								</div>
					        </div>
					        
					        <div style="clear:both;"></div>
							
						</div>	
						
						<div class="container-fluid">
							<g:render template="/content/content_cover_block_square_angular_v2" />
						</div>
					</div>
				</div>
			</div>
		
			<g:render template="/home/footer" />
			
		</div>
		
		<g:include controller="channel" action="addChannelPanel" />
		<g:include controller="category" action="addCategoryPanel" params="[btnaction: 'home', channel: params.channel]" />
		
		<asset:javascript src="home/angular_map_home_app.js"/>
	</body>
</html>