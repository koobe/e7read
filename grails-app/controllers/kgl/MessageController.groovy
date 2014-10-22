package kgl

import org.springframework.security.access.annotation.Secured

@Secured(["ROLE_USER"])
class MessageController {
	
	def static MSGBOARD_PAGESIZE = 10;
	
	def springSecurityService
	
    def index() {
		[
			max: MSGBOARD_PAGESIZE,
			totalSize: MessageBoard.countByUserAOrUserB(springSecurityService.currentUser, springSecurityService.currentUser)
		]
	}
	
	def conversation(String id) {
		log.info "message baord id: ${id}"
	}
	
	/**
	 * [AJAX] render message board table
	 * @return
	 */
	def renderMessageBoardTable() {
		
		def messageBoardList = MessageBoard.findAllByUserAOrUserB(
			springSecurityService.currentUser,
			springSecurityService.currentUser,
			[
				sort: 'lastMessageDate',
				order: 'desc',
				max: params.max,
				offset: params.offset
			])
		
		messageBoardList.each { messageBoard ->
			def count = Message.countByMessageBoardAndIsRead(messageBoard, false);
			messageBoard.unread = count
		}
		
		if (messageBoardList.size() > 0) {
			render template: "messageboard_table", model: [messageBoardList: messageBoardList]
		} else {
			render ""
		}
	}
	
	
}
