package kgl

import java.util.Date;

class Book {
	
	String id = UUID.randomUUID().toString()
	
	String name
	
	String description
	
	String issn
	
	String isbn
	
	String ean
	
	AwsS3File pdfFile
	
	String pdfFileUrl
	
	String originalFileName
	
	Boolean unedited
	
	Boolean finishedUpload
	
	Boolean isDelete
	
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
		pdfFile nullable: true
		pdfFileUrl nullable: true
		originalFileName nullable: true
		unedited nullable: true
		finishedUpload nullable: true
		isDelete nullable: true
		publisher nullable: true
    }
	
	static mapping = {
		id generator:'assigned'
		pages sort: 'dataIndex'
	}
}
