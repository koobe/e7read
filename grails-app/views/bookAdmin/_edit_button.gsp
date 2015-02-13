<div class="button-group">
	<div class="form-group">
		<div class="col-sm-12">
			<div class="pull-right">
				
				<div class="edit-button">
					<button type="submit" class="btn btn-danger">離開</button>
				</div>
				
				<div class="edit-button">
					<button type="submit" class="btn btn-success">儲存</button>
				</div>
				
				<g:if test="${!book?.isChecked}">
				<div class="edit-button">
					<button type="submit" class="btn btn-success">審核確認</button>
				</div>
				</g:if>
				
			</div>
		</div>
	</div>
</div>