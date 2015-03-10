<div class="col-xs-12 category-content-panel-block" 
	ng-repeat="content in categoryContents[category.name]"
	ng-class="{ 'col-sm-{{ content.cols}}': true } " 
	ng-mouseover="mouseoverBlock(content.id + content.stamp);" 
	ng-mouseleave="mouseoverLeave(content.id + content.stamp);"
	ng-click="openContent(content.id);">
	
	<div style="display: table;
		table-layout: fixed;
		width:100%; height: 6em; 
		border: 1px solid #CCC;
		border-radius: 5px;">
		
		<div style="display: table-row;">
		
			<div class="category-content-panel-block-image" ng-if="content.imageSide == 0"
				ng-style="{ 'background-image': 'url(' + content.coverUrl + ')' }">
			</div>
			
			<div style="display: table-cell; width: 60%; padding: 7px 7px 0px 7px;">
				
				<marquee ng-attr-id="{{ 'marquee-' + content.id + content.stamp }}" scrollamount="4" ng-class="{}" style="font-weight: 700; display:none;">
					{{ content.cropTitle }}
				</marquee>
				
				<div ng-attr-id="{{ 'title-' + content.id + content.stamp }}" class="text-nowrap" ng-class="{}" style="font-weight: 700; overflow:hidden; text-overflow: ellipsis;">
					{{ content.cropTitle }}
				</div>
				
				<div class="category-content-panel-block-text" style="font-size: 0.8em; overflow:hidden; text-overflow: ellipsis;">
					<p>
						{{ content.cropText }}
					</p>
				</div>
				
			</div>
			
			<div class="category-content-panel-block-image" ng-if="content.imageSide == 1"
				ng-style="{ 'background-image': 'url(' + content.coverUrl + ')' }">
			</div>
			
		</div>
	
	</div>
	
</div>