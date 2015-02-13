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

<div class="form-group">
	<label class="col-sm-2 control-label">出版社</label>
	<div class="col-sm-10">
		<g:select class="form-control" name="publisher" from="${publishers}" optionKey="id" optionValue="name" value="${book?.publisher?.id}" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">ISBN</label>
	<div class="col-sm-10">
		<g:textField name="isbn" class="form-control" placeholder="ISBN" value="${book?.isbn}" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">ISSN</label>
	<div class="col-sm-10">
		<g:textField name="issn" class="form-control" placeholder="ISSN" value="${book?.issn}" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">EAN</label>
	<div class="col-sm-10">
		<g:textField name="ean" class="form-control" placeholder="EAN" value="${book?.ean}" />
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">初版日期</label>
	<div class="col-sm-10">
		<g:datePicker name="datePublish" precision="day" value="${book?.datePublish}"/>
	</div>
</div>