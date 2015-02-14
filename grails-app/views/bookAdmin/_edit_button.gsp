<div class="button-group">
	<div class="form-group">
		<div class="col-sm-12">
			<div class="pull-right">
				
				<div class="edit-button">
					<g:link class="btn btn-danger" controller="bookAdmin" action="${session?.bookAdminNavigation?.prevAction}" 
						params="${session?.bookAdminNavigation?.params}">
						離開
					</g:link>
				</div>
				
				<div class="edit-button">
					<g:link class="btn btn-danger delete-button" uri="#">
						刪除
					</g:link>
				</div>
				
				<div class="edit-button">
					<button type="submit" class="btn btn-success save-button">儲存</button>
				</div>
				
				<g:if test="${!book?.isChecked}">
					<div class="edit-button">
						<g:link class="btn btn-success confirm-button" uri="#">
							審核確認
						</g:link>
					</div>
				</g:if>
				
			</div>
		</div>
	</div>
</div>