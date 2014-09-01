package kgl

class Category {

	static belongsTo = [
		category: Category
	]
	
	static hasMany = [
		categorys: Category
	]
	
    String name
	
	Integer rankOnTop
	
	Boolean enable
	
	Integer order

    static constraints = {
        name size: 2..15, blank: false, unique: true
		rankOnTop nullable: true
		enable nullable: true
		order nullable: true
    }
	
	static mapping = {
		order column: '`order`'
		categorys sort: 'name'
		enable defaultValue: 1
	}
}
