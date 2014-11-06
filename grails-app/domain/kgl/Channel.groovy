package kgl

class Channel {
	
	static searchable = {
//		root false
		only = ['id', 'name']
	}
	
//	static searchable = true
	
	String id
	
	String name
	
	Boolean isDefault
	
	String logoImg
	
	Boolean canAnonymous
	
    static constraints = {
		id maxSize: 32
		logoImg nullable: true
		canAnonymous nullable: true
    }
	
	static mapping = {
		id generator: 'uuid'
	}
}
