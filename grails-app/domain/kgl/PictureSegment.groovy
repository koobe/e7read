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
	
	static searchable = {
		root false
		only = ['id', 'dataIndex', 'thumbnailUrl', 'originalUrl']
		
		dataIndex index: "no"
		thumbnailUrl index: "no"
		originalUrl index: "no"
	}
	
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

        s3File nullable: true
    }
}
