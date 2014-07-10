package kgl

import org.springframework.aop.TrueClassFilter;

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

	static hasMany = [templateSegment: TemplateSegment]
	
    static constraints = {
		textCount blank: false
		mediaCount blank: false
		html blank: false
    }
	
	static mapping = {
		group column: '`group`'
	}
}
