package kgl

class Channel {
	
	static searchable = {
//		root false
		only = ['id', 'name', 'iconUrl']
	}
	
//	static searchable = true
	
	String id
	
	String name
	
	Boolean isDefault
	
	String logoImg

    String iconUrl      // icon for google map marker
	
	Boolean canAnonymous
	
    static constraints = {
		id maxSize: 32
		logoImg nullable: true
		canAnonymous nullable: true
        iconUrl nullable: true, blank: true
    }
	
	static mapping = {
		id generator: 'uuid'
	}
}
