<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false"></script>
<asset:javascript src="ngAutocomplete.js"/>

<asset:javascript src="content/content_coverflow_app.js"/>

<asset:stylesheet src="content/content_cover_block_square.css"/>

<style>
	.indent {
	    margin-left: 50px;
	}
	
	.move-down {
	    margin-top: 100px;
	}
</style>
<script type="text/javascript">
	$(function() {
		$('#place_button').click(function() {
			if (isGeoReady) {
				$('#place_button').hide();
				$('#place_input').css('display', 'inline');
				$('#place_input').focus();
				$('#place_input').select();
			}
		});

		$('#place_input').blur(function() {
			$('#place_button').show();
			$('#place_input').css('display', 'none');
		});
	});
</script>
<div class="container flow-container" ng-controller="CoverFlowController">
	<div style="border: 1px solid white; padding: 10px 5px 10px 4px;">
		
		<div style="display:inline-block; vertical-align: middle;" ng-controller="GPlacesAutoCompCtrl">
			<span>附近：</span>
			<button id="place_button" class="btn btn-default" style="padding: 2px 11px 2px 11px;">
				{{ locationName? locationName : '正在取得位置資訊...' }}
			</button>
			
			<input id="place_input" type="text" class="gplaces-input" id="Autocomplete" ng-autocomplete="result" 
				details="details" options="options" />
				
			<a href="javascript:void(0);" ng-click="returnMyLocation()">我的位置</a>
		</div>
		
		<div style="display:inline-block; float:right; vertical-align: middle;">
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

	<g:render template="/content/content_cover_block_square_angular"></g:render>
</div>
