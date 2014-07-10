package kgl

/**
 * 
 * @author Cloude
 * @since 2014-07-01
 */
class TemplateSegment {
	
	OriginalTemplate originalTemplate
	
	String type
	Integer componentWidth
	Integer componentHeight

    static constraints = {
		type blank:false
    }
}
