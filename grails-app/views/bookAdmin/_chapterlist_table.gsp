<div>
	<table class="table table-hover">
		<tr>
			<th align="center" class="table-header" style="width: 80px;"><i class="fa fa-file-image-o"></i>&nbsp;順序</th>
			<th align="center" class="table-header" style=""><i class="fa fa-book"></i>&nbsp;標題</th>
			<th align="center" class="table-header"><i class="fa fa-book"></i>&nbsp;描述</th>
			<th align="center" class="table-header"><i class="fa fa-building"></i>&nbsp;開始頁</th>
			<th align="center" class="table-header"><i class="fa fa-building"></i>&nbsp;結束頁</th>
			<th align="center" class="table-header" style="width: 100px;">&nbsp;</th>
		</tr>
		
		<g:if test="${chapters}">
			<g:each in="${chapters}" var="chapter">
				
				<tr class="chapter-row" style="cursor: pointer;" data-bookid="${book?.id}" data-chapterid="${chapter?.id}">
					<td valign="middle" style="vertical-align:middle; text-align: center;">
						${chapter?.dataIndex}
					</td>
					<td valign="middle" style="vertical-align:middle">
						${chapter?.title}
					</td>
					<td valign="middle" style="vertical-align:middle">
						${chapter?.description}
					</td>
					<td valign="middle" style="vertical-align:middle">
						${chapter?.pageStart?.dataIndex}
					</td>
					<td valign="middle" style="vertical-align:middle">
						${chapter?.pageEnd?.dataIndex}
					</td>
					
					<td valign="middle" style="vertical-align:middle; text-align: center;">
						<div><g:link uri="#">刪除</g:link></div>
					</td>
				</tr>
				
			</g:each>
		</g:if>
		
	</table>
</div>