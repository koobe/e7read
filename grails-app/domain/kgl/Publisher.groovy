package kgl

class Publisher {
	
	String id
	
	String name

    static constraints = {
    }
	
	static mapping = {
		id generator: 'uuid'
	}
}
