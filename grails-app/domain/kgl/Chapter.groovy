package kgl

class Chapter {
	
	String id
	
	String title
	
	String description
	
	Integer dataIndex
	
	static belongsTo = [
		book: Book
	]

    static constraints = {
		description nullable: true, maxSize: 1024
    }
	
	static mapping = {
		id generator: 'uuid'
	}
}
