<div class="page-range-selector">

	<div class="container page-range-container">
		
		<div class="row">
			<div class="col-xs-6 nopadding">
				開始頁
			</div>
			<div class="col-xs-6 nopadding">
				結束頁
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-6 nopadding">
				<g:textField id="startPageData" class="form-control ajax-page-meta" name="startPage" value="${chapter?.pageStart?.dataIndex}" data-imagedomid="startImageDom" />
			</div>
			<div class="col-xs-6 nopadding">
				<g:textField id="endPageData" class="form-control ajax-page-meta" name="endPage" value="${chapter?.pageEnd?.dataIndex}" data-imagedomid="endImageDom" />
			</div>
		</div>
		
		<div style="height: 10px;"></div>
		
		<div class="row">
			<div class="col-xs-6 nopadding">
				<img id="startImageDom" class="img-responsive" alt="" src="${chapter?.pageStart?.thumbnailUrl}">
			</div>
			<div class="col-xs-6 nopadding">
				<img id="endImageDom" class="img-responsive" alt="" src="${chapter?.pageEnd?.thumbnailUrl}">
			</div>
		</div>
		
		<div class="page-range-message">
			
		</div>
		
		<div class="button-group">
			<div class="form-group">
				<div class="col-sm-12">
					<div class="pull-right">
						<div class="edit-button">
							<g:link class="btn btn-danger page-range-selector-btn-cancel" uri="javascript:void(0);">
								取消
							</g:link>
						</div>
						<div class="edit-button">
							<g:link class="btn btn-success page-range-selector-btn-confirm" uri="javascript:void(0);">
								確定
							</g:link>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>

</div>