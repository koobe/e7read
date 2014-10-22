<div class="message-table-container">

		<table class="table table-hover">
			<tr>
				<th align="center" class="table-header"><i class="fa fa-clock-o"></i>&nbsp;時間</th>
				<th align="center" class="table-header"><i class="fa fa-book"></i>&nbsp;貼文</th>
				<th align="center" class="table-header"><i class="fa fa-comment-o"></i>&nbsp;傳訊</th>
				<th align="center" class="table-header"><i class="fa fa-user"></i>&nbsp;對象</th>
			</tr>
			
			<g:if test="${messageBoardList}">
				<g:each in="${messageBoardList}" var="messageBoard">
					
					<tr class="open-conversation" data-message-board-id="${messageBoard.id}">
						<td>
							<g:formatDate date="${messageBoard.lastMessageDate}" format="MM/dd HH:mm" />
						</td>
						<td >
							<div>
								<a href="/share/${messageBoard.content?.id}" target="_blank">
									${messageBoard.content?.cropTitle}
								</a>
							</div>
						</td>
						<td>
							<a href="/message/conversation/${messageBoard.id}" target="_blank">
								<span>${messageBoard.lastMessage}</span>
								<span style="color: #999;"><i class="fa fa-envelope"></i> ${messageBoard.unread}</span>
							</a>
						</td>
						<td>
							<a  href="#">${messageBoard.communicateUser?.fullName}</a>
						</td>
					</tr>
				</g:each>
			</g:if>
			
		</table>
		
		<g:if test="${messageBoardList}">
		</g:if>
		<g:else>
			<div style="text-align: center; color:#888; font-size: 1em; font-weight: 700;">
				<i class="fa fa-spinner fa-spin"></i> Loading
			</div>
		</g:else>
</div>