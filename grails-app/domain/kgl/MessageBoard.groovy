package kgl

class MessageBoard {
	
	transient springSecurityService
	
	String id
	
	String lastMessage
	
	Date lastMessageDate
	
	Integer unread
	
	static belongsTo = [
		content: Content,
		userA: User,
		userB: User
	]
	
	static mapping = {
		id generator: 'uuid'
	}

    static constraints = {
		// if content is null, this is a personal message not related to a content
		content nullable: true
    }
	
	static transients = ['communicateUser', 'unread']
	
	User getCommunicateUser() {
		if (springSecurityService?.currentUser == userA) {
			return userB
		} else {
			return userA
		}
	}
}
