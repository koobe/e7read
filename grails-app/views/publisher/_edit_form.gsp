
<g:if test="${publisher?.id}">
	<div class="form-group">
		<label class="col-sm-2 control-label">識別碼</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" name="id" placeholder="識別碼" value="${publisher?.id}" disabled="disabled" />
		</div>
	</div>
</g:if>

<div class="form-group">
	<label class="col-sm-2 control-label">名稱</label>
	<div class="col-sm-10">
		<input type="text" class="form-control" name="name" placeholder="名稱" value="${publisher?.name}" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">網址</label>
	<div class="col-sm-10">
		<input type="text" class="form-control" name="websiteUrl" placeholder="網址" value="${publisher?.websiteUrl}" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">說明</label>
	<div class="col-sm-10">
		<g:textArea class="form-control" name="description" placeholder="說明" rows="5" value="${publisher?.description}"></g:textArea>
	</div>
</div>
