package kgl

import grails.converters.JSON
import org.springframework.security.access.annotation.Secured

@Secured(["ROLE_USER"])
class MessageController {
	
	def static MSGBOARD_PAGESIZE = 10;
	static MESSAGE_PAGESIZE = 6;
	
	def springSecurityService
	
	static allowedMethods = [
		getMessageData: 'GET',
		postMessageData: 'POST'
	]
	
    def index() {
		[
			max: MSGBOARD_PAGESIZE,
			totalSize: MessageBoard.countByUserAOrUserB(springSecurityService.currentUser, springSecurityService.currentUser)
		]
	}
	
	def conversation(String id) {
		[
			max: MESSAGE_PAGESIZE,
			totalSize: Message.countByMessageBoard(MessageBoard.get(id)),
			messageBoardId: id
		]
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
	
	/**
	 * [AJAX] get message data
	 * @return
	 */
	def getMessageData() {
		
		log.info "message board id: ${params.id}, lastTimeStamp: ${params.lastTime}, max: ${params.max}, offset: ${params.offset}"
		
		def messageList
		def jsonDataMap = [:]
		def jsonMessageList = []
		
		jsonDataMap.put('lastTime', null)
		jsonDataMap.put('results', jsonMessageList)
		
		if (params.lastTime) {
			
			Long stamp = Long.parseLong(params.lastTime)
			Date date = new Date(stamp)
			
			messageList = Message.findAllByMessageBoardAndSendTimeLessThanEquals(
				MessageBoard.findById(params.id),
				date,
				[
					sort: 'sendTime',
					order: 'desc',
					max: params.max,
					offset: params.offset
				])
		} else {
		
			messageList = Message.findAllByMessageBoard(
				MessageBoard.findById(params.id),
				[
					sort: 'sendTime',
					order: 'desc',
					max: params.max,
					offset: params.offset
				])
			
			if (messageList.size() > 0) {
				Date lastTime = messageList.get(0).sendTime
				jsonDataMap.put('lastTime', lastTime.getTime())
			}
		}
		
		messageList.each { message ->
			
			def dataMap = [:]
			dataMap.put('messageId', message.id)
			dataMap.put('message', message.message)
			dataMap.put('sendTime', message.sendTime.getTime())
			dataMap.put('senderId', message.user.id)
			dataMap.put('sender', message.user.fullName)
			
			def side
			if (springSecurityService?.currentUser == message.user) {
				side = 'me'
			} else {
				side = 'other'
			}
			dataMap.put('side', side)
			
			jsonMessageList << dataMap
		}
		
		render jsonDataMap as JSON
	}
	
	/**
	 * [AJAX] post message data
	 * @return
	 */
	def postMessageData() {
		
		def messageBoard = MessageBoard.get(params.mbId)
		def msg = params.message
		def date = new Date()
		def currUser = springSecurityService?.currentUser
		
		if (messageBoard.userA == currUser || messageBoard.userB == currUser) {
			
			def message = new Message(message: msg, messageBoard: messageBoard, sendTime: date, user: currUser, isRead: false)
			message.save flush: true
			
			render [:] as JSON
			
		} else {
			response.sendError 403
		}
		
	}
	
}
