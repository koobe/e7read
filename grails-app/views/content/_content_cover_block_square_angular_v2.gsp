<div class="content-cover-block-square col-xs-{{colXs}} col-sm-{{colSm}} col-md-{{colMd}}" 
		ng-repeat="content in contents" data-contentid="{{content.id}}">


	<div class="block-body" ng-click="openContent(content.id)">

		<div class="thumbnail-cover block-title-image" style="
		height: 140px;
		width: 100%;"
			 ng-style="{ 'background-image': 'url(' + content.coverUrl + ')' }">

			<!--
			<div class="block-image-title">
				<div class="location" style="font-size: 0.9em; font-weight: 700;">
					{{ content.distance? (content.distance | number : 2) + '公里, ' : '' }}
					{{ content.datePosted | date: 'yyyy/MM/dd' }}
				</div>
			</div> -->
		</div>

		<div class="block-inner">

			<div class="block-title">
				<span>{{content.cropTitle}}</span>
			</div>
			<div class="block-separator"></div>
			<div style="padding-top: 3px;">
				<div style="display:inline-block;" class="tipmsg" data-tipmsg="View in Map">
					<span class="fa fa-map-marker" style="cursor:pointer;" ng-click="openMapInfoWindow(content.id); $event.stopPropagation();"></span>
					<span style="cursor:pointer; color: #337ab7;" ng-click="openMapInfoWindow(content.id); $event.stopPropagation();">
						{{ content.distance? (content.distance | number : 2) + 'KM' : '' }}
					</span>
				</div>

				<div class="content-cover-author" style="display:inline-block; float:right; padding:0;">
					<span>
						<i class="fa fa-user"></i>
						<!-- <a class="content-author-name" ng-click="showAuthor(content.user.id); $event.stopPropagation();">{{ content.user.fullName }}</a> -->
						<span>{{ content.user.fullName }}</span>
					</span>
				</div>
			</div>


			<div>

				<div ng-if="content.tradingContentAttribute.price">
					<i class="fa fa-usd"></i>
					<span>{{ content.tradingContentAttribute.price }}</span>
				</div>
				<div ng-if="!content.tradingContentAttribute.price">
					<span>　</span>
				</div>

				<div ng-switch on="content.jsonAttrs.tradeType">
					<div ng-switch-when="buy">
						<span class="label label-success">
							<i class="fa fa-shopping-cart"></i>
							Buy
						</span>
					</div>
					<div ng-switch-when="sell">
						<span class="label label-success">
							<i class="fa fa-tag"></i>
							Sell
						</span>
					</div>
					<div ng-switch-default>
						&nbsp;
					</div>
				</div>

				<div style="float:right;">
					<i class="fa fa-calendar"></i>
					<span>{{ content.datePosted | date: 'yyyy/MM/dd' }}</span>
				</div>
				<div style="clear:both;"></div>
			</div>

		</div>
		
	</div>
</div>