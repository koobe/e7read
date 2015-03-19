<div>
	<table class="table table-hover">
		<tr>
			<th align="center" class="table-header" style="width: 80px;"><i class="fa fa-file-image-o"></i>&nbsp;封面</th>
			<th align="center" class="table-header" style="width: 150px;"><i class="fa fa-book"></i>&nbsp;書號</th>
			<th align="center" class="table-header"><i class="fa fa-book"></i>&nbsp;書名</th>
			<th align="center" class="table-header"><i class="fa fa-book"></i>&nbsp;頻道</th>
			<th align="center" class="table-header"><i class="fa fa-book"></i>&nbsp;內容類別</th>
			<th align="center" class="table-header"><i class="fa fa-book"></i>&nbsp;內容標題</th>
			<th align="center" class="table-header"><i class="fa fa-book"></i>&nbsp;分配日期</th>
			<th align="center" class="table-header" style="width: 100px;">&nbsp;</th>
		</tr>
		
		<g:if test="${contents}">
			<g:each in="${contents}" var="content">
				
				<tr class="book-row" style="cursor: pointer;" >
				
					<td valign="middle" style="vertical-align:middle; text-align: center;">
						<div>
							<img alt="" src="${content.coverUrl}" style="height: 70px" />
						</div>
					</td>
					<td valign="middle" style="vertical-align:middle; color: #888; font-size: 0.8em;">
						<div contenteditable="true">${content.bookContentAttribute?.book?.id}</div>
					</td>
					<td valign="middle" style="vertical-align:middle">
						${content.bookContentAttribute?.book?.name}
					</td>
					<td valign="middle" style="vertical-align:middle">
						${content.channel?.name}
					</td>
					<td valign="middle" style="vertical-align:middle">
						${content.categories[0]?.name}
					</td>
					<td valign="middle" style="vertical-align:middle">
						${content.cropTitle}
					</td>
					<td valign="middle" style="vertical-align:middle">
						<g:formatDate date="${content.dateCreated}" format="MM/dd HH:mm" />
					</td>
					<td valign="middle" style="vertical-align:middle; text-align: center;">
						<div><g:link uri="/viewer/open?book=${content.bookContentAttribute?.book?.id}" target="_blank">閱覽書籍</g:link></div>
						<div><g:link uri="javascript:void(0);">刪除分配</g:link></div>
					</td>
				</tr>
			</g:each>
		</g:if>
		
	</table>
</div>