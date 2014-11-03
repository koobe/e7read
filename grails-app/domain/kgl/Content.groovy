package kgl

class Content {

    static searchable = {
        only = ['cropText', 'cropTitle', 'lastUpdated', 'location']
        location geoPoint: true, component: true
    }

    GeoPoint location

    String id

	String cropTitle
	String cropText
	
	String coverUrl
	
	Boolean hasPicture
	Boolean isPrivate
	Boolean isDelete

    Boolean isShowContact = false

    Date dateCreated
    Date lastUpdated
	
	Date datePosted

    String editableHashcode

    /**
     * Kepp owner email for anonymous post
     */
    String ownerEmail

	//TODO
	@Deprecated
	String fullText

    // References (URLs) for the content.
    String references
	
	static hasMany = [
		textSegments: TextSegment,
		pictureSegments: PictureSegment,
		categories: Category
	]
	
	static belongsTo = [
		user: User,
		template: OriginalTemplate,
		channel: Channel
	]

    static mapping = {
        id generator: 'uuid'
		textSegments sort: 'dataIndex'
		
		references column: '`references`'
    }

    static constraints = {
		id maxSize: 32
        fullText maxSize: 1024 * 1024
        cropTitle nullable: true, maxSize: 1024
		cropText nullable: true, maxSize: 512 * 1024
		coverUrl nullable: true
		template nullable: true
        references nullable: true
        editableHashcode nullable: true
		datePosted nullable: true
        ownerEmail nullable: true
        location nullable: true
    }
	
	def beforeInsert() {
		if (datePosted == null) {
			datePosted = new Date()
		}
	 }
}
