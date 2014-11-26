<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    
	    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.2/angular.min.js"></script>
		<script src="//code.angularjs.org/1.3.2/angular-resource.min.js"></script>
	    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false"></script>
	    
	    <style type="text/css">
	    	body {
	    		background-color: #FAF8F5;
	    	}
    	
	    	.title {
	    		display: inline-block;
	    		
	    		padding-top: 18px;
	    		padding-bottom: 18px;
	    		
	    		font-size: 2em;
	    		font-weight: 700;
	    		letter-spacing: 1px;
	    		
	    		color: #444;
	    	}
	    	
	    	.sub-title {
	    		display: inline-block;
	    		
	    		font-family: Arial,sans-serif;
	    		font-style: italic;
	    		font-size: 1.1em !important;
	    		font-weight: 300;
	    		color: #888;
	    		letter-spacing: 1px;
	    		
	    		padding-left: 10px;
	    		padding-bottom: 30px;
	    	}
	    	
	    	.tips {
	    		font-size: 1.1em !important;
	    		font-weight: 300;
	    		letter-spacing: 1px;
	    		
	    		padding-bottom: 10px;
	    		color: #333;
	    	}
	    	
	    	.choice {
	    		font-size: 1.1em !important;
	    		font-weight: 300;
	    		letter-spacing: 1px;
	    		
	    		padding: 20px 0px 0px 0px;
	    		color: #333;
	    	}
	    	
	    	.choice-block {
	    		border: 1px solid #ccd6dd;
	    		border-radius: 4px;
	    		background-color: #fff;
	    		font-size: 0.9em;
	    		text-align: left;
	    		padding: 10px 10px 10px 20px;
	    		margin: 0px auto;
	    	}
	    	
	    	.tip {
	    		font-size: 0.8em;
	    		line-height: 1.5em;
	    		letter-spacing: 1px;
	    		color: #888;	
	    	}
    	</style>
    
	    
	</head>
	<body>
		<div class="container" ng-app="MapWelcomeApp" ng-controller="MapWelcomeMainController">
			<g:render template="/home/section_title" model="[sectionTitle: '我的位置', fontAwesome: '']"></g:render>
			
			<div>
				<div class="title">Welcome to E7LIFE.</div>
    			<div class="sub-title">-Share everything around your nearby locations</div>
			</div>
     		
     		<div class="tips">您可以在生活周遭，分享您最喜愛的事物。為了更好的服務體驗，請提供您最常使用的地點、或地標，例如：捷運站、商家、建築物等。</div>
     		
     		<div class="choice" ng-controller="GooglePlaceAutoCompleteController">
     			輸入您的位置：
     			<div style="padding-top: 3px;">
		     		<input id="place_input" type="text" class="gplaces-input form-control" id="Autocomplete" 
		     			ng-autocomplete="result" 
						details="details" 
						options="options" ng-model="locationName" />
				</div>
				<div>
	     			<a href="/map/prompt" style="white-space: nowrap; padding-left: 5px;" target="_blank">開啟地圖</a>
	     			<a href="javascript:void(0);" style="white-space: nowrap; padding-left: 5px;" ng-click="setLocationBySensor()">自動定位</a>
	     		</div>
	     		
	     		<input type="hidden" name="lat" ng-value="locationLon" />
				<input type="hidden" name="lon" ng-value="locationLat" />
				<input style="display:none;" type="input" name="geolocation" ng-change="setLocationByMap()" ng-model="geolocation" />
     		</div>
     		
     		<div class="choice">
     			您已選擇位置：
     			<div class="choice-block" style="margin-top: 3px;">
     				<div>經度：{{locationLon}}</div>
     				<div>緯度：{{locationLat}}</div>
     				<div>地點名稱：{{locationName}}</div>
     			</div>
     			<div class="tip">
     				備註：您之後可以在個人檔案中修改位置資訊。
     			</div>
     		</div>
     		
     		<div style="display: table; padding-top: 40px; width:100%;">
     			<div style="display:table-cell; vertical-align:middle;">
     				<div style="float:right; padding-right:10px;">
     					<a id="button-ignore" href="/">下次再提醒我</a>
     				</div>
     			</div>
				<div style="display:table-cell;">
					<a href="javascript:void(0);" ng-click="saveMyLocation()" id="button-confirm" style="width:100%;" class="koobe-text-btn koobe-text-btn-default">確定</a>
		        </div>
     		</div>
     		
		</div>
		
		<g:render template="/home/footer" />
		
	    <asset:javascript src="ngAutocomplete.js"/>
	    <asset:javascript src="map/welcome.js"/>
	</body>
</html>