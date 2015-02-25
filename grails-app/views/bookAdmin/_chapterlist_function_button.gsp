<div class="button-group">
	<div class="form-group">
		<div class="col-sm-12" style="padding-bottom: 20px;">
			<div class="pull-right">
				
				<div class="edit-button">
					<g:link class="btn btn-success delete-button" uri="/bookAdmin/chapter?bookId=${book?.id}">
						新增
					</g:link>
				</div>
								
				<div class="edit-button">
					<g:link class="btn btn-danger" controller="bookAdmin" action="${session?.bookAdminNavigation?.prevAction}" 
						params="${session?.bookAdminNavigation?.params}">
						離開
					</g:link>
				</div>
				
			</div>
		</div>
	</div>
</div>