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

    static constraints = {
        name size: 2..15, blank: false, unique: true
		rankOnTop nullable: true
    }
	
	static mapping = {
		categorys sort: 'name'
	}
}
