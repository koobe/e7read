package kgl

import java.util.Date;

class Book {
	
	String id = UUID.randomUUID().toString()

	String name

	String description
	
	String issn
	
	String isbn
	
	String ean
	
	Boolean unedited
	
	Boolean finishedUpload
	
	Date dateCreated
	
	Date lastUpdated
	
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
		unedited nullable: true
		finishedUpload nullable: true
		publisher nullable: true
    }
	
	static mapping = {
		id generator:'assigned'
		pages sort: 'dataIndex'
	}
}
