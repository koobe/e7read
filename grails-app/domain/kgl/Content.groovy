package kgl

import groovy.json.JsonSlurper
import groovy.json.JsonOutput

class Content {

    private static final Date NULL_DATE = new Date(0)

    static searchable = {
        only = [
			'user', 
			'cropTitle', 'cropText', 'dateCreated', 'lastUpdated', 'datePosted', 
			'location', 'channel', 'categories', 
			'type',
			'coverUrl', 'iconUrl', 'isPrivate', 'isDelete', 'isShowLocation', 
			'pictureSegments',
			'tradingContentAttribute', 'bookContentAttribute',
			'jsonAttrs'
		]
		
		
		channel parent: true, component: true
		tradingContentAttribute component: true
		bookContentAttribute component: true
		user component: true
		categories component: true
		pictureSegments component: true
		location geoPoint: true, component: true
		
		type index: "not_analyzed"
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
	Date validateDateBegin
	Date validateDateEnd

    String editableHashcode

	/**
	 * Store string type attributes in JSON format
	 */
	String jsonAttrs = '{}'

    /**
     * Kepp owner email for anonymous post
     */
    String ownerEmail

	//TODO
	@Deprecated
	String fullText

    // References (URLs) for the content.
    String references
	
	/**
	 * null: Normal content
	 * EBOOK: Ebook content 
	 */
	String type
	
	static hasMany = [
		textSegments: TextSegment,
		pictureSegments: PictureSegment,
		categories: Category
	]
	
	static hasOne = [
		tradingContentAttribute :TradingContentAttribute,
		bookContentAttribute: BookContentAttribute
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

		jsonAttrs type: 'text'
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
		tradingContentAttribute nullable: true
		bookContentAttribute nullable: true
		type nullable: true
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

		if (validateDateBegin == null) {
			validateDateBegin = new Date()
		}

		if (validateDateEnd == null) {
			validateDateEnd = new Date() + 7
		}

        if (isShowContact == null) {
            isShowContact = false
        }
        if (isShowLocation == null) {
            isShowLocation = true
        }
    }

	def getJsonAttr(String key) {
		def object = new JsonSlurper().parseText(jsonAttrs)
		object[key]
	}

	def getJsonAttr(String key, Object defaultValue) {
		getJsonAttr(key)?:defaultValue
	}

	void setJsonAttr(String key, Object value) {
		def object = new JsonSlurper().parseText(jsonAttrs)
		object[key] = value
		jsonAttrs = new JsonOutput().toJson(object)
	}
}
