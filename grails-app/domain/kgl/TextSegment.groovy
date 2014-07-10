package kgl

class TextSegment {
	
	Content content
	
	String elementId
	String text

    static constraints = {
		elementId blank: false
    }
}
