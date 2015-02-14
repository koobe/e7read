<div>
	<table class="table table-hover">
		<tr>
			<th align="center" class="table-header" style="width: 100px;"><i class="fa fa-file-image-o"></i>&nbsp;封面</th>
			<th align="center" class="table-header"><i class="fa fa-book"></i>&nbsp;書名</th>
			<th align="center" class="table-header"><i class="fa fa-building"></i>&nbsp;出版社</th>
			<th align="center" class="table-header" style="width: 100px; vertical-align:middle; text-align: center;"><i class="fa fa-calendar"></i>&nbsp;初版日期</th>
			<th align="center" class="table-header" style="width: 100px; vertical-align:middle; text-align: center;"><i class="fa fa-files-o"></i>&nbsp;頁數</th>
			<th align="center" class="table-header" style="width: 100px; vertical-align:middle; text-align: center;"><i class="fa fa-calendar"></i>&nbsp;上傳日期</th>
			<th align="center" class="table-header" style="width: 100px;">&nbsp;</th>
		</tr>
		
		<g:if test="${books}">
			<g:each in="${books}" var="book">
				
				<tr class="book-row" style="cursor: pointer;" data-bookid="${book?.id}">
					<td>
						<div>
							<img alt="" src="${book.coverUrl}" style="height: 50px" />
						</div>
					</td>
					<td valign="middle" style="vertical-align:middle">
						${book.name}
					</td>
					<td valign="middle" style="vertical-align:middle">
						${book.publisher?.name}
					</td>
					<td valign="middle" style="vertical-align:middle; text-align: center;">
						<g:formatDate date="${book.datePublish}" format="yyyy/MM/dd" />
					</td>
					<td valign="middle" style="vertical-align:middle; text-align: center;">
						${book.pages?.size()}
					</td>
					<td valign="middle" style="vertical-align:middle; text-align: center;">
						<g:formatDate date="${book.dateCreated}" format="MM/dd HH:mm" />
					</td>
					<td valign="middle" style="vertical-align:middle; text-align: center;">
						<g:link uri="#">閱覽</g:link>
					</td>
				</tr>
			</g:each>
		</g:if>
		
	</table>
</div>