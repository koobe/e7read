
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

<div class="form-group row">
	<label class="col-sm-2 control-label">選擇頁面</label>
	<div class="col-sm-4">
		<a class="btn btn-default btn-select-page-range">選擇...</a>
	</div>
</div>

<div class="form-group row">
	<label class="col-sm-2 control-label">開始頁</label>
	<div class="col-sm-4">
		<input type="text" class="form-control" name="pageStartNumber" placeholder="開始頁" value="${chapter?.pageStart?.dataIndex}" disabled="disabled" />
	</div>
	<label class="col-sm-2 control-label">結束頁</label>
	<div class="col-sm-4">
		<input type="text" class="form-control" name="pageEndNumber" placeholder="結束頁" value="${chapter?.pageEnd?.dataIndex}" disabled="disabled" />
	
		<!-- <g:select class="form-control" name="pageEnd" from="${pages}" optionKey="id" optionValue="dataIndex" noSelection="['':'選擇']" value="${chapter?.pageEnd?.id}" /> -->
		
	</div>
</div>


<!-- 
<div class="form-group row">
	<label class="col-sm-2 control-label">開始頁</label>
	<div class="col-sm-4">
		<input type="text" class="form-control" name="pageStart" placeholder="開始頁" value="${chapter?.pageStart?.id}" />
	</div>
</div>

<div class="form-group row">
	<label class="col-sm-2 control-label">結束頁</label>
	<div class="col-sm-4">
		<input type="text" class="form-control" name="pageEnd" placeholder="開始頁" value="${chapter?.pageEnd?.id}" />
	</div>
</div> -->

<g:hiddenField name="pageStart" value="${chapter?.pageStart?.id}" />
<g:hiddenField name="pageEnd" value="${chapter?.pageEnd?.id}" />