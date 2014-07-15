package kgl

class TextSegment {
	
	Content content
	
	String dataIndex
	String text

    static constraints = {
		dataIndex blank: false
    }
}
