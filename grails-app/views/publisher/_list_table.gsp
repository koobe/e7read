<div>
	<table class="table table-hover">
		<tr>
			<th align="center" class="table-header" style="width: 100px;"><i class="fa fa-book"></i>&nbsp;識別碼</th>
			<th align="center" class="table-header"><i class="fa fa-book"></i>&nbsp;名稱</th>
			<th align="center" class="table-header"><i class="fa fa-book"></i>&nbsp;說明</th>
			<th align="center" class="table-header"><i class="fa fa-book"></i>&nbsp;網址</th>
			<th align="center" class="table-header" style="width: 100px;"><i class="fa fa-book"></i>&nbsp;建立日期</th>
			<th align="center" class="table-header" style="width: 100px;"><i class="fa fa-book"></i>&nbsp;修改日期</th>
			<th align="center" class="table-header" style="width: 100px;">&nbsp;</th>
		</tr>
		
		<g:if test="${publishers}">
			<g:each in="${publishers}" var="publisher">
				
				<tr class="publisher-row" style="cursor: pointer;" data-publisherid="${publisher.id}">
					<td valign="middle" style="vertical-align:middle; text-align: left; font-size: 0.8em;">
						${publisher.id}
					</td>
					<td valign="middle" style="vertical-align:middle; text-align: left;">
						${publisher.name}
					</td>
					<td valign="middle" style="vertical-align:middle; text-align: left;">
						${publisher.description}
					</td>
					<td valign="middle" style="vertical-align:middle; text-align: left;">
						${publisher.websiteUrl}
					</td>
					<td valign="middle" style="vertical-align:middle; text-align: center;">
						<g:formatDate date="${publisher.dateCreated}" format="yyyy/MM/dd" />
					</td>
					<td valign="middle" style="vertical-align:middle; text-align: center;">
						<g:formatDate date="${publisher.lastUpdated}" format="yyyy/MM/dd" />
					</td>
					<td valign="middle" style="vertical-align:middle; text-align: center;">
						<div><g:link uri="#">刪除</g:link></div>
					</td>
				</tr>
			</g:each>
		</g:if>
	</table>
</div>