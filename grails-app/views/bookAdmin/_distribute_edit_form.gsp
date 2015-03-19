
<g:hiddenField name="bookId" value="${book?.id}" />

<div class="form-group">
	<label class="col-sm-2 control-label">書號</label>
	<div class="col-sm-10">
		<input type="text" class="form-control" name="book.id" placeholder="書號" value="${book?.id}" disabled="disabled" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">書名</label>
	<div class="col-sm-10">
		<input type="text" class="form-control" name="book.name" placeholder="書名" value="${book?.name}" disabled="disabled" />
	</div>
</div>

<div class="form-group row">
	<label class="col-sm-2 control-label">內容類別</label>
	<div class="col-sm-4">
		<g:select class="form-control" name="categoryId" from="${categories}" optionKey="id" optionValue="name" noSelection="['':'選擇']" value="" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">內容標題</label>
	<div class="col-sm-10">
		<input type="text" class="form-control" name="cropTitle" placeholder="內容標題" value="${book?.name}" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">內容描述</label>
	<div class="col-sm-10">
		<g:textArea class="form-control" name="cropText" placeholder="內容描述" rows="5" value="${book?.description}"></g:textArea>
	</div>
</div>

