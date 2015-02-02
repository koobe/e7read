package kgl

class Page {
	
	String id
	
	Integer dataIndex
	
	String imageFileUrl
	
	String thumbnailFileUrl
	
	AwsS3File imageFile
	
	AwsS3File thumbnailFile
	
	String fullText
	
	static belongsTo = [
		book: Book
	]

    static constraints = {
		imageFileUrl nullable: true
		thumbnailFileUrl nullable: true
		imageFile nullable: true
		thumbnailFile nullable: true
		fullText nullable: true, maxSize: 1024 * 1024
    }
	
	static mapping = {
		id generator: 'uuid'
	}
}
