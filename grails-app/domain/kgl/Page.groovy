package kgl

class Page {
	
	String id
	
	Integer dataIndex
	
	String bucket
	
	String imageKey
	
	String thumbnailKey
	
	AwsS3File imageFile
	
	AwsS3File thumbnailFile
	
	String fullText
	
	String imageUrl
	
	String thumbnailUrl
	
	static transients = ['imageUrl', 'thumbnailUrl']
	
	static belongsTo = [
		book: Book
	]

    static constraints = {
		bucket nullable: true
		imageKey nullable: true
		thumbnailKey nullable: true
		imageFile nullable: true
		thumbnailFile nullable: true
		fullText nullable: true, maxSize: 1024 * 1024
    }
	
	static mapping = {
		id generator: 'uuid'
	}
}
