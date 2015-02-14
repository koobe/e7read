package kgl

import java.util.Date;

class Book {
	
	String id = UUID.randomUUID().toString()
	
	String name
	
	String description
	
	String issn
	
	String isbn
	
	String ean
	
	String author
	
	String orginalAuthor
	
	String translator
	
	String illustrator
	
	Date datePublish
	
	Double priced
	
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
	
	static searchable = {
		only = [
			'id', 'name', 
			'publisher',
			'author', 'orginalAuthor', 'translator', 'illustrator',
			'bucket', 'pdfFileKey',
			'datePublish', 'dateCreated', 'lastUpdated',
			'isChecked', 'finishedUpload', 'isDelete'
		]
		
		publisher component: true
		
		bucket index: "no"
		pdfFileKey index: "no"
		isChecked index: "not_analyzed"
		finishedUpload index: "not_analyzed"
		isDelete index: "not_analyzed"
	}
	
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
		author nullable: true
		orginalAuthor nullable: true
		translator nullable: true
		illustrator nullable: true
		datePublish nullable: true
		priced nullable: true
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
