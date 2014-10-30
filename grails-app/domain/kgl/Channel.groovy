package kgl

class Channel {
	
	String id
	
	String name
	
	Boolean isDefault
	
	String logoImg
	
	Boolean canAnonymous

    static searchable = {
        root false
    }
	
    static constraints = {
		id maxSize: 32
		logoImg nullable: true
		canAnonymous nullable: true
    }
	
	static mapping = {
		id generator: 'uuid'
	}
}
