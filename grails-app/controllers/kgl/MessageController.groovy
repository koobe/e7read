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
		
		jsonDataMap.put('lastPrevMsgTime', null)
		jsonDataMap.put('firstNewerMsgTime', null)
		jsonDataMap.put('results', jsonMessageList)
		
		if (newer) {
			
			if (!firstNewerMsgTime) {
				firstNewerMsgTime = lastPrevMsgTime
			}
			
			Long stamp = Long.parseLong(firstNewerMsgTime)
			Date date = new Date(stamp)
//			log.info "Fetch newer: ${date.getTime()}"
			
			messageList = Message.findAllByMessageBoardAndSendTimeGreaterThan(
				MessageBoard.findById(mbId),
				date,
				[
					sort: 'sendTime',
					order: 'asc'
				])
			
			if (messageList.size() > 0) {
				Date lastTime = messageList.get(messageList.size()-1).sendTime
				jsonDataMap.put('firstNewerMsgTime', lastTime.getTime())
			}
		} else if (lastPrevMsgTime) {
//			log.info "Fetch Before ${lastPrevMsgTime}"
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
				jsonDataMap.put('lastPrevMsgTime', lastTime.getTime())
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
			
			def dataMap = [:]
			dataMap.put('messageId', message.id)
			dataMap.put('message', message.message)
			dataMap.put('sendTime', message.sendTime.getTime())
			dataMap.put('senderId', message.user.id)
			dataMap.put('sender', message.user.fullName)
			
			render dataMap as JSON
			
		} else {
			response.sendError 403
		}
		
	}
	
}
