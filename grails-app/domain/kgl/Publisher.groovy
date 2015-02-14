package kgl

class Publisher {
	
	String id
	
	String name
	
	static searchable = {
		only = [
			'id', 'name'
		]
	}

    static constraints = {
    }
	
	static mapping = {
		id generator: 'uuid'
	}
}
