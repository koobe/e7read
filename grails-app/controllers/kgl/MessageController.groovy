package kgl

import grails.converters.JSON

import org.springframework.security.access.annotation.Secured

@Secured(["ROLE_USER"])
class MessageController {
	
	def static MSGBOARD_PAGESIZE = 8;
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
	
	/**
	 * Open conversation view, if message board is not found than create new one
	 * @param id
	 * @return
	 */
	def conversation(String id) {
		
		def messageCount
		def messageBoardId
		
		if (!id) {
			
			def contentId = params.contentId
			def meId = springSecurityService.currentUser.id
			
			def content = Content.get(contentId)
			
			if (content) {
				
				def query = """
					from MessageBoard
					where content.id = :contentId 
					and ((userA.id = :userAId and userB.id = :userBId) or (userA.id = :userBId and userB.id = :userAId))
				"""
				
				def messageBoardList = MessageBoard.executeQuery(query,
					[
						contentId: contentId,
						userAId: content.user.id,
						userBId: meId
					]
				)
				
				if (messageBoardList.size() > 0) {
					
					messageBoardId = messageBoardList.get(0).id
					messageCount = Message.countByMessageBoard(messageBoardList.get(0))
					
				} else {
					
					if (content.user == springSecurityService.currentUser) {
						
						render view: 'nocontacter'
					} else {
						
						log.info 'create new message board...'
						
						def messageBoard = new MessageBoard(
							content: content,
							userA: springSecurityService.currentUser,
							userB: content.user
						);
						messageBoard.save flush: true
						log.info messageBoard.errors
						
						messageBoardId = messageBoard.id
						messageCount = 0
					}
					
				}
				
			} else {
				response.sendError(404)
			}
			
		} else {
			messageBoardId	= id
			messageCount = Message.countByMessageBoard(MessageBoard.get(id))
		}
		
		[
			max: MESSAGE_PAGESIZE,
			totalSize: messageCount,
			messageBoardId: messageBoardId
		]
	}
	
	/**
	 * [AJAX] render message board table
	 * @return
	 */
	def renderMessageBoardTable() {
		
		def query = """
			from MessageBoard
			where (userA.id = :meId or userB.id = :meId) and lastMessageDate is not null
			order by lastMessageDate desc
		"""
		
		def messageBoardList = MessageBoard.executeQuery(query, [meId: springSecurityService.currentUser.id], 
			[
				max: params.max,
				offset: params.offset
			])
		
//		def messageBoardList = MessageBoard.findAllByUserAOrUserBAndLastMessageDateIsNotNull(
//			springSecurityService.currentUser,
//			springSecurityService.currentUser,
//			[
//				sort: 'lastMessageDate',
//				order: 'desc',
//				max: params.max,
//				offset: params.offset
//			])
		
		messageBoardList.each { messageBoard ->
			def count = Message.countByMessageBoardAndUserNotEqualAndIsRead(messageBoard, springSecurityService.currentUser, false);
			messageBoard.unread = count
			
//			def lastMessage = Message.findByMessageBoard(
//				messageBoard, 
//				[
//					sort: 'sendTime', 
//					order: 'desc',
//					max: 1,
//					offset: 0
//				])
//			
//			messageBoard.lastMessage = lastMessage.message
//			messageBoard.lastMessageDate = lastMessage.sendTime
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
		
		def mbId = params.mbId
		def lastPrevMsgTime = params.lastPrevMsgTime
		def newer = params.newer	// true or false
		def firstNewerMsgTime = params.firstNewerMsgTime
		def max = params.max
		def offset = params.offset
		
//		log.info """
//			message board id: ${mbId}, 
//			lastPrevMsgTime: ${lastPrevMsgTime}, 
//			max: ${max}, offset: ${offset},
//			newer: ${newer}, firstNewerMsgTime: ${firstNewerMsgTime}
//		"""
		
		def messageList
		def jsonDataMap = [:]
		def jsonMessageList = []
		
		jsonDataMap.lastPrevMsgTime = null
		jsonDataMap.firstNewerMsgTime = null
		jsonDataMap.results = jsonMessageList
		
		if (newer) {
			
			if (!firstNewerMsgTime) {
				if (!lastPrevMsgTime) {
					firstNewerMsgTime = new Date(0).getTime()
				} else {
					firstNewerMsgTime = lastPrevMsgTime	
				}
			}
			
			Long stamp = new Long(firstNewerMsgTime)
			Date date = new Date(stamp)
			
			messageList = Message.findAllByMessageBoardAndSendTimeGreaterThan(
				MessageBoard.findById(mbId),
				date,
				[
					sort: 'sendTime',
					order: 'asc'
				])
			
			if (messageList.size() > 0) {
				Date lastTime = messageList.get(messageList.size()-1).sendTime
				jsonDataMap.firstNewerMsgTime = lastTime.getTime()
			}
		} else if (lastPrevMsgTime) {
		
			Long stamp = Long.parseLong(lastPrevMsgTime)
			Date date = new Date(stamp)
			
			messageList = Message.findAllByMessageBoardAndSendTimeLessThanEquals(
				MessageBoard.findById(mbId),
				date,
				[
					sort: 'sendTime',
					order: 'desc',
					max: max,
					offset: offset
				])
		} else {
		
			messageList = Message.findAllByMessageBoard(
				MessageBoard.findById(mbId),
				[
					sort: 'sendTime',
					order: 'desc',
					max: max,
					offset: offset
				])
			
			if (messageList.size() > 0) {
				Date lastTime = messageList.get(0).sendTime
				jsonDataMap.lastPrevMsgTime = lastTime.getTime()
			}
		}
		
		messageList.each { message ->
			
			def dataMap = [:]
			dataMap.messageId = message.id
			dataMap.message = message.message
			dataMap.sendTime = message.sendTime.getDateTimeString()
			dataMap.senderId = message.user.id
			dataMap.sender = message.user.fullName
			
			def side
			if (springSecurityService?.currentUser == message.user) {
				side = 'me'
			} else {
				side = 'other'
				message.isRead = true
				message.save flush: true	// make message read
			}
			dataMap.side = side
			
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
			
			def dataMap = [:]
			dataMap.messageId = message.id
			dataMap.message = message.message
			dataMap.sendTime = message.sendTime.getTime()
			dataMap.senderId = message.user.id
			dataMap.sender = message.user.fullName
			
			messageBoard.lastMessage = message.message
			messageBoard.lastMessageDate = message.sendTime
			
			render dataMap as JSON
			
		} else {
			response.sendError 403
		}
	}
	
	/**
	 * [AJAX] get unread message count
	 * @return
	 */
	def getUnreadMessageCount() {
		
		def query = """
			select count(m) from Message m
			where (m.messageBoard.userA.id = :userId or m.messageBoard.userB.id = :userId)
			and m.isRead = :isRead and m.user.id <> :userId
		"""
		
		def count = Message.executeQuery(query, [userId: springSecurityService.currentUser.id, isRead: false])
		
		def jsonDataMap = [:]
		jsonDataMap.unreadMessageCount = count.get(0)
		
		render jsonDataMap as JSON
	}
	
}
