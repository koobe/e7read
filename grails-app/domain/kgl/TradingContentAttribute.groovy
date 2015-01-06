package kgl

class TradingContentAttribute {
	
	static searchable = {
		root false
		only = ['price', 'number']
	}
	
	Content content
	
	Double price
	
	Integer number

    static constraints = {
		price nullable: true
		number nullable: true
    }
}
