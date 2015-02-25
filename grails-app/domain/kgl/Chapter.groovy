package kgl

class Chapter {
	
	String id
	
	String title
	
	String description
	
	Page pageStart
	
	Page pageEnd
	
	Integer dataIndex
	
	static belongsTo = [
		book: Book
	]

    static constraints = {
		title nullable: true
		description nullable: true, maxSize: 1024
		pageStart nullable: true
		pageEnd nullable: true
		dataIndex nullable: true
    }
	
	static mapping = {
		id generator: 'uuid'
	}
}
