package kgl

class Content {

    String id

	String cropTitle
	String cropText
	
	String coverUrl
	
	Boolean hasPicture
	Boolean isPrivate
	Boolean isDelete

    Date dateCreated
    Date lastUpdated
	
	//TODO
	@Deprecated
	String fullText

    // References (URLs) for the content.
    String references
	
	static hasMany = [
		textSegments: TextSegment,
		pictureSegments: PictureSegment,
	]
	
	static belongsTo = [
		user: User,
		template: OriginalTemplate
	]

    static mapping = {
        id generator: 'uuid'
		textSegments sort: 'dataIndex'
    }

    static constraints = {
		id maxSize: 32
        fullText maxSize: 1024 * 1024
        cropTitle nullable: true, maxSize: 1024
		cropText nullable: true, maxSize: 512 * 1024
		coverUrl nullable: true
		template nullable: true
    }
}
