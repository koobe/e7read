package kgl

import java.util.Date;

class Publisher {
	
	String id
	
	String name
	
	Date dateCreated
	
	Date lastUpdated
	
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
