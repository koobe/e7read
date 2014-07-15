package kgl

public enum OriginalTemplateType {
    HTML,
    GSP
}

/**
 *
 * @author Cloude
 * @since 2014-07-01
 */
class OriginalTemplate {

    /**
     * Name for findByName search, like ID, not for human readable display
     */
    String name

	Integer textCount
	Integer mediaCount
	
	String group
	
	String html

    OriginalTemplateType type

	static hasMany = [templateSegment: TemplateSegment]
	
    static constraints = {
		textCount blank: false
		mediaCount blank: false
		html maxSize: 1024 * 1024, blank: false
    }
	
	static mapping = {
		group column: '`group`'
	}
}
