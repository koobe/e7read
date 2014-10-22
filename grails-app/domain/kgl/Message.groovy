package kgl

class Message {
	
	String id
	
	String message
	
	Date sendTime
	
	Boolean isRead
	
	static belongsTo = [
		messageBoard: MessageBoard,
		user: User
	]
	
	static mapping = {
		id generator: 'uuid'
	}

    static constraints = {
		message nullable: false, maxSize: 1024 * 1024
		sendTime nullable: false 
    }
}
