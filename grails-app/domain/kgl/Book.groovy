package kgl

import java.util.Date;

class Book {
	
	String id = UUID.randomUUID().toString()
	
	String name
	
	String description
	
	String issn
	
	String isbn
	
	String ean
	
	Date datePublish
	
	Boolean isChecked
	
	Boolean unedited
	
	Boolean finishedUpload
	
	Boolean isDelete
	
	Date dateCreated
	
	Date lastUpdated
	
	AwsS3File pdfFile
	
	String bucket
	
	String pdfFileKey
	
	String originalFileName
	
	String coverUrl
	
	static belongsTo = [
		publisher: Publisher
	]
	
	static hasMany = [
		pages: Page
	]
	
	static transients = ['coverUrl']

    static constraints = {
		description nullable: true, maxSize: 1024
		issn nullable: true
		isbn nullable: true
		ean nullable: true
		datePublish nullable: true
		isChecked nullable: true
		pdfFile nullable: true
		bucket nullable: true
		pdfFileKey nullable: true
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
