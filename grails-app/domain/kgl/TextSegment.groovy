package kgl

class TextSegment {
	
	String id
	
	String dataIndex
	String text
	
	static belongsTo = [
		content: Content,
	]
	
	static mapping = {
		id generator: 'uuid'
	}

    static constraints = {
		id maxSize: 32
		dataIndex blank: false
		text maxSize: 8000
    }
}
