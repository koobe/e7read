<div class="form-group">
	<label class="col-sm-2 control-label">封面</label>
	<div class="col-sm-10">
		<g:img uri="${book?.coverUrl}" style="height: 100px;"/>
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">書號</label>
	<div class="col-sm-10">
		<input type="text" class="form-control" name="id" placeholder="書號" value="${book?.id}" disabled="disabled" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">書名</label>
	<div class="col-sm-10">
		<input type="text" class="form-control" name="name" placeholder="書名" value="${book?.name}" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">書本簡介</label>
	<div class="col-sm-10">
		<g:textArea class="form-control" name="description" placeholder="書本簡介" rows="5" value="${book?.description}"></g:textArea>
	</div>
</div>

<div class="form-group row">
	<label class="col-sm-2 control-label">出版社</label>
	<div class="col-sm-4">
		<g:select class="form-control" name="publisher" from="${publishers}" optionKey="id" optionValue="name" noSelection="['':'選擇']" value="${book?.publisher?.id}" />
	</div>
	<label class="col-sm-2 control-label">初版日期</label>
	<div class="col-sm-4 form-inline date-picker">
		<g:datePicker name="datePublish" precision="day" noSelection="['':'選擇']" default="none" value="${book?.datePublish}"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-sm-2 control-label">ISBN</label>
	<div class="col-sm-4">
		<g:textField name="isbn" class="form-control" placeholder="ISBN" value="${book?.isbn}" />
	</div>
	<label class="col-sm-2 control-label">ISSN</label>
	<div class="col-sm-4">
		<g:textField name="issn" class="form-control" placeholder="ISSN" value="${book?.issn}" />
	</div>
</div>

<div class="form-group row">
	<label class="col-sm-2 control-label">EAN</label>
	<div class="col-sm-4">
		<g:textField name="ean" class="form-control" placeholder="EAN" value="${book?.ean}" />
	</div>
	<label class="col-sm-2 control-label">定價</label>
	<div class="col-sm-4">
		<g:textField name="priced" class="form-control" placeholder="定價" value="${book?.priced}" />
	</div>
</div>

<div class="form-group row">
	<label class="col-sm-2 control-label">作者</label>
	<div class="col-sm-4">
		<g:textField name="author" class="form-control" placeholder="作者" value="${book?.author}" />
	</div>
	<label class="col-sm-2 control-label">原文作者</label>
	<div class="col-sm-4">
		<g:textField name="orginalAuthor" class="form-control" placeholder="原文作者" value="${book?.orginalAuthor}" />
	</div>
</div>

<div class="form-group row">
	<label class="col-sm-2 control-label">譯者</label>
	<div class="col-sm-4">
		<g:textField name="translator" class="form-control" placeholder="譯者" value="${book?.translator}" />
	</div>
	<label class="col-sm-2 control-label">繪者</label>
	<div class="col-sm-4">
		<g:textField name="illustrator" class="form-control" placeholder="繪者" value="${book?.illustrator}" />
	</div>
</div>

<g:hiddenField name="isChecked" value="${book?.isChecked}" />

<g:hiddenField name="isDelete" value="${book?.isDelete}" />

