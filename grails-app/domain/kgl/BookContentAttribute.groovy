package kgl

class BookContentAttribute {
	
	static searchable = {
		root false
		only = ['book']
		
		book component: true
	}
	
	Content content
	
	Book book

    static constraints = {
    }
}
