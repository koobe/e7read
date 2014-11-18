package kgl

class Content {

    private static final Date NULL_DATE = new Date(0)

    static searchable = {
        only = [
			'user', 
			'cropTitle', 'cropText', 'lastUpdated', 'datePosted', 
			'location', 'channel', 'categories', 
			'coverUrl', 'iconUrl', 'isPrivate', 'isDelete', 'isShowLocation'
		]
		
		
		channel parent: true, component: true
		user component: true
		categories component: true
		location geoPoint: true, component: true
		
		coverUrl index: "no"
		isPrivate index: "not_analyzed"
		isDelete index: "not_analyzed"
		isShowLocation index: "not_analyzed"
    }

    String id

	String cropTitle
	String cropText
	
	GeoPoint location
	
	String coverUrl
    String iconUrl      // icon for google map marker
	
	Boolean hasPicture
	Boolean isPrivate
	Boolean isDelete

    Boolean isShowContact

    Boolean isShowLocation

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
        iconUrl nullable: true, blank: true
    }

    def beforeValidate() {
        __field_initialize()
    }
	
	def beforeInsert() {
        __field_initialize()
	}

    private void __field_initialize() {
        //if (datePosted == null) {
        if (datePosted == null) {
            datePosted = new Date()
        }
        if (isShowContact == null) {
            isShowContact = false
        }
        if (isShowLocation == null) {
            isShowLocation = true
        }
    }
}
