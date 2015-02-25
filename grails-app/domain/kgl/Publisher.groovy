package kgl


class Publisher {
	
	String id
	
	String name
	
	String description
	
	String websiteUrl
	
	Date dateCreated
	
	Date lastUpdated
	
	static searchable = {
		only = [
			'id', 'name'
		]
	}

    static constraints = {
		description nullable:true
		websiteUrl nullable:true
    }
	
	static mapping = {
		id generator: 'uuid'
	}
}
