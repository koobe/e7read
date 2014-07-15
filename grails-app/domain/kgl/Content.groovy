package kgl

class Content {

    /**
     * Use UUID for Content id
     */
    String id

    /**
     * Store full text content upload by user
     */
    String fullText

    /**
     * Store all images upload by user
     */
    static hasMany = [images: S3File, textSegments: TextSegment]

    User user
	OriginalTemplate originalTemplate
	
	String cropTitle
	String cropText
	
	String coverUrl
	
	Boolean hasPicture
	Boolean isPrivate
	Boolean isDelete

    Date dateCreated
    Date lastUpdated

    static mapping = {
        id generator: 'uuid'
    }

    static constraints = {
        fullText maxLength: 1024 * 1024

        cropTitle nullable: true, maxLength: 1024
		cropText nullable: true, maxLength: 64 * 1024
		coverUrl nullable: true
    }
}
