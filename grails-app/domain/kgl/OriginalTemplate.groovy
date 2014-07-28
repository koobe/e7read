package kgl

public enum OriginalTemplateRenderType {
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
	
	String grouping = 'default'
	
	String html

    OriginalTemplateRenderType renderType

	static hasMany = [templateSegment: TemplateSegment]
	
    static constraints = {
		textCount blank: false
		mediaCount blank: false
		html maxSize: 8000, blank: false
    }
	
	static mapping = {
		//group column: '`group`'
	}

    public static OriginalTemplate getDefaultTemplate() {
        OriginalTemplate.findByNameAndGrouping('default', 'default')
    }
}
