package kgl

class TextSegment {
	
	String id
	
	Content content
	
	String dataIndex
	String text
	
	static mapping = {
		id generator: 'uuid'
	}

    static constraints = {
		dataIndex blank: false
		text type: 'text'
    }
}
