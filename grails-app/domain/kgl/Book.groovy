package kgl

class Book {
	
	String id
	
	String name
	
	String description
	
	String issn
	
	String isbn
	
	String ean
	
	static belongsTo = [
		publisher: Publisher
	]
	
	static hasMany = [
		pages: Page
	]

    static constraints = {
		description nullable: true, maxSize: 1024
		issn nullable: true
		isbn nullable: true
		ean nullable: true
		publisher nullable: true
    }
	
	static mapping = {
		id generator: 'uuid'
		pages sort: 'dataIndex'
	}
}
