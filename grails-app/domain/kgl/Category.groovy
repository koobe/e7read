package kgl

class Category {
	
	static searchable = {
		root false
		only = ['id', 'name']
	}

	static belongsTo = [
		category: Category,
		channel: Channel
	]
	
	static hasMany = [
		categorys: Category
	]
	
	Long id
	
    String name
	
	Integer rankOnTop
	
	Boolean enable
	
	Integer order

    String iconUrl      // icon for google map marker

    static constraints = {
        name size: 2..15, blank: false, unique: true
		rankOnTop nullable: true
		enable nullable: true
		order nullable: true
        iconUrl nullable: true, blank: true
    }
	
	static mapping = {
		order column: '`order`'
		categorys sort: 'name'
		enable defaultValue: 1
	}
}
