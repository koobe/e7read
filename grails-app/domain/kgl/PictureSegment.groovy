package kgl

/**
 * 
 * @author Cloude
 * 
 */
class PictureSegment {
	
	String id
	
	String dataIndex
	
	String thumbnailUrl
	String originalUrl
	
	static belongsTo = [
		content: Content,
		s3File: S3File
	]
	
	static mapping = {
		id generator: 'uuid'
	}

    static constraints = {
		id maxSize: 32
		thumbnailUrl nullable: true
		originalUrl blank: false
		dataIndex blank: false
    }
}
