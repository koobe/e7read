package kgl

class Category {

	static belongsTo = [
		category: Category
	]
	
    String name

    static constraints = {
        name size: 2..15, blank: false, unique: true
    }
}
