package kgl

class AwsS3File {
	
	Long id
	
	String contentType
	
	Long contentLength
	
	String bucket
	
	String objectKey
	
	String resourceUrl
	
	String remark

    static constraints = {
		remark nullable: true
    }
}
