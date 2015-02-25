
<div class="form-group row">
	<label class="col-sm-2 control-label">書籍</label>
	<div class="col-sm-4">
		<g:select class="form-control" name="book" from="${books}" optionKey="id" optionValue="name" value="${chapter?.book?.id}" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">章節標題</label>
	<div class="col-sm-10">
		<input type="text" class="form-control" name="title" placeholder="章節標題" value="${chapter?.title}" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">章節描述</label>
	<div class="col-sm-10">
		<g:textArea class="form-control" name="description" placeholder="章節描述" rows="5" value="${chapter?.description}"></g:textArea>
	</div>
</div>
