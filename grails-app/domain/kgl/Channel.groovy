package kgl

class Channel {
	
	static searchable = {
		only = ['id', 'name', 'iconUrl']
	}
	
	String id
	
	String name
	
	Boolean isDefault
	
	String logoImg

    String iconUrl      // icon for google map marker
	
	Boolean canAnonymous
	
	Boolean showInPanel
	
	Integer order
	
    static constraints = {
		id maxSize: 32
		logoImg nullable: true
		canAnonymous nullable: true
        iconUrl nullable: true, blank: true
    }
	
	static mapping = {
		order column: '`order`'
		id generator: 'uuid'
	}
}
