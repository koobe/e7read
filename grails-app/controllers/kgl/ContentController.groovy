package kgl

import grails.plugin.geocode.Point
import org.elasticsearch.common.unit.DistanceUnit
import org.elasticsearch.search.sort.SortBuilders
import org.elasticsearch.search.sort.SortOrder

import static org.springframework.http.HttpStatus.*

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.springframework.web.multipart.commons.CommonsMultipartFile

@Secured(["ROLE_USER"])
@Transactional
class ContentController {

	def grailsApplication
    def geocodingService
    def springSecurityService
    def templateService
    def s3Service
    def contentService
    def elasticSearchService
	def loggingService

    static allowedMethods = [get: "GET", save: ['POST', 'PUT'], update: "PUT", delete: "DELETE"]

    def index() {
		[]
    }
	
	@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def get() {
		def id = params.id;
		def content = Content.get(id);
		
		JSON.use("deep")
		if (checkContent(content)) {
			render [:] as JSON
		} else {
			render content as JSON
		}
	}

    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def show(Content contentInstance) {

        if (!contentInstance) {
            notFound()
            return
        }

		[
			content: contentInstance
        ]
    }

    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def embed(Content contentInstance) {
		
		def checkAction = checkContent(contentInstance)
		
		if (checkAction) {
			if (checkAction.equals('deteted')) {
				render view: 'hasdeleted', model: [channel: contentInstance.channel]
			} else {
				render view: 'haslocked', model: [channel: contentInstance.channel]
			}
		} else {
		
			loggingService.addReadingLog(
				session? session.id: null,
				request.getHeader("User-Agent"),
				springSecurityService.currentUser? springSecurityService.currentUser.id: null,
				contentInstance.channel.id,
				contentInstance.id)
		
			def template = OriginalTemplate.get(params.template?.id)
			def output
	
			if (!template) {
				output = templateService.render(contentInstance)
			} else {
				output = templateService.render(contentInstance, template)
			}
			render contentType: 'text/html', text: output
		}
    }

    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def create() {
		
		def channelName = getChannelName(params)
		def channel = Channel.findByName(channelName)
		
		if (channel) {
			session['channel'] = channel
		} else {
			response.sendError(404)
		}
		
		// can post content anonymously?
		if (!channel.canAnonymous) {
			if (!springSecurityService.currentUser) {
				session['redirect_logged'] = "/content/create/${channelName}"
				redirect uri: '/login/auth'
			}
		}
		
		log.info "Enter create content page, channelName is ${channelName}"

        User user = springSecurityService.currentUser

        def location
        def lat, lon

        if (user && user.location) {
			
            location = user.location.city

            lat = user.location.lat
            lon = user.location.lon
			
        } else if (session['geolocation']) {

            def geolocation = session['geolocation']

            lat = geolocation.lat?.toDouble()
            lon = geolocation.lon?.toDouble()

            location = geocodingService.getAddress(
                    new Point(latitude: lat, longitude: lon),
                    [language: 'zh-TW']
            ).addressComponents[3].shortName // index value 3 ;=> city name
        }

		[
                location: location,
                lat: lat, lon: lon
        ]
    }

    @Transactional
    def save(Content contentInstance) {
		
		if (request.method == 'POST') {
			
			log.info "Save content ${contentInstance.cropText}. ${new Date()}"
			
			if (contentInstance == null) {
				notFound()
				return
			}
	
			contentInstance.images = []
			List<CommonsMultipartFile> imageFiles = params.list("imageFiles")
	
			imageFiles.each { imageFile ->
				if (!imageFile.isEmpty()) {
					log.info "Receive image file: ${imageFile.originalFilename} (Content-Type: ${imageFile.contentType})"
	
					def s3file = new S3File()
	
					s3file.owner = springSecurityService.currentUser
					s3file.file = imageFile
					s3file.isPublic = true
					s3file.remark = 'USER-UPLOAD-IMAGE'
	
					// use auto-create objectKey instead
					//s3file.objectKey = "${imageFile.originalFilename}"
	
					s3Service.upload(s3file, imageFile.inputStream)
	
					s3file.save flush: true
	
					contentInstance.images << s3file
				}
			}
	
			// Use the first line of full text as crop text
			contentInstance.cropTitle = contentInstance.fullText?.split("\n")?.first()?.take(30)
			contentInstance.cropText = contentInstance.fullText?.split("\n")?.first()
	
			if (contentInstance.images) {
				contentInstance.coverUrl = contentInstance.images.first().unsecuredUrl
			}
	
			contentInstance.hasPicture = contentInstance.images?true:false
			contentInstance.isDelete = false
			contentInstance.isPrivate = false
	
			contentInstance.user = springSecurityService.currentUser
			contentInstance.originalTemplate = OriginalTemplate.defaultTemplate
	
			contentInstance.validate()
	
			if (contentInstance.hasErrors()) {
				respond contentInstance.errors, view:'create'
				return
			}
	
			contentInstance.save flush: true
	
			redirect controller: 'content', action: 'personal'
			
		} else if (request.method == 'PUT') {
		
			log.info params
			log.info contentInstance
		
		}
        
		
//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.created.message', args: [message(code: 'content.label', default: 'Content'), contentInstance.id])
//                redirect contentInstance
//            }
//            '*' { respond contentInstance, [status: CREATED] }
//        }
    }

    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def share(Content contentInstance) {

        if (!contentInstance) {
            redirect uri: '/'
            return
        }
		
		def checkAction = checkContent(contentInstance)
		if (checkAction) {
			if (checkAction.equals('deteted')) {
				render view: 'hasdeleted', model: [channel: contentInstance.channel]
			} else {
				render view: 'haslocked', model: [channel: contentInstance.channel]
			}
		} else {
		
			loggingService.addReadingLog(
				session? session.id: null,
				request.getHeader("User-Agent"),
				springSecurityService.currentUser? springSecurityService.currentUser.id: null,
				contentInstance.channel.id,
				contentInstance.id)
		
			render contentType: 'text/html', text: templateService.render(contentInstance)
		}
    }

    def edit(Content contentInstance) {

        def template = OriginalTemplate.get(params.template?.id)

        if (!contentInstance) {
            redirect uri: '/'
            return
        }

        respond contentInstance, model: [
                templates: OriginalTemplate.createCriteria().list {
                    order('grouping', 'asc')
                    order('name', 'asc')
                },
                template: template
        ]
    }

    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def modifyByHash(String hash) {
        def content = Content.findByEditableHashcode(hash)

        if (content) {
            // Add content allow list to session
            session.setAttribute KglConstant.SESSION_KEY_LATEST_CONTENT_ID, content.id
        }

        redirect action: 'modify', id: content.id
    }

    /**
     * Content re-editing, both for anonymous and registered user.
     *
     * @param id
     */
    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def modify(Content content) {

        if (!content) {
            redirect uri: '/'
            return
        }

        // Only allow owner modify content or anonymous post who create it.
        if (content.user != springSecurityService.currentUser) {

            if (session.getAttribute(KglConstant.SESSION_KEY_LATEST_CONTENT_ID) != content.id) {
                response.sendError 403
                return
            }
        }
		
		params.channel = content.channel.name

		def checkAction = checkContent(content)
		if (checkAction) {
			redirect action: checkAction
		} else {
			respond content, model: [params: params]
		}
    }

    @Transactional
    def update(Content contentInstance) {
        if (contentInstance == null) {
            notFound()
            return
        }

        if (contentInstance.hasErrors()) {
            respond contentInstance.errors, view:'edit'
            return
        }

        contentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Content.label', default: 'Content'), contentInstance.id])
                redirect contentInstance
            }
            '*'{ respond contentInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Content contentInstance) {

        if (contentInstance == null) {
            notFound()
            return
        }

        contentInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Content.label', default: 'Content'), contentInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
	// TEST
	def contents() {
		render Content.list(params) as JSON
	}
	
	// TEST
	@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def count() {
		[content: Content.list().get(0)]
	}
	
	def collectAllSubCategory = { categorys, category ->
		categorys << category.name
		if (category.categorys) {
			category.categorys.each { subcate ->
				owner.call(categorys, subcate)
			}
		}
	}
	
	@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def renderContentsHTML() {
		
		def contentList = []
		def categoryList = []
		
		def channelName = getChannelName(params)
		
		if (params.q) {
			log.info 'search content: {' + params.q + '}'
			def searchResult = Content.search(params.q, [size: params.max, from: params.offset])
			searchResult.searchResults.each { result ->
				def content = Content.get(result.id)
				if (content && !content.isDelete && !content.isPrivate && content.channel.name.equals(channelName)) {
					contentList << content
				}
			}
		} else if (params.c) {
			def category = Category.findByName(params.c)
			if (category) {collectAllSubCategory(categoryList, category)}
			if (categoryList.size() > 0) {
				def hql = """
				select distinct content 
				from Content as content join content.categories category 
				where category.name in (:categories) and content.isDelete = false and content.isPrivate = false and content.channel.name = :channelName
				order by content.datePosted desc, content.lastUpdated desc
				"""
				contentList = Content.executeQuery(hql, [categories: categoryList, channelName: channelName], [max: params.max, offset: params.offset])
			}
		} else if (params.u) {
			def hql = """
				select content 
				from Content as content
				where content.user.id = :userId and content.isDelete = false and content.isPrivate = false and content.channel.name = :channelName
				order by content.datePosted desc, content.lastUpdated desc
			"""
			def u = new Long(params.u)
			contentList = Content.executeQuery(hql, [userId: u, channelName: channelName], [max: params.max, offset: params.offset])
		} else {
			def hql = """
				select content 
				from Content as content
				where content.isDelete = false and content.isPrivate = false and content.channel.name = :channelName
				order by content.datePosted desc, content.lastUpdated desc
			"""
			contentList = Content.executeQuery(hql, [channelName: channelName], [max: params.max, offset: params.offset])
		}
		
		if (channelName.equals('trade')) {
			renderContentCoverBlockSquare(contentList)
		} else {
			renderContentContainerHTML(contentList)
		}
	}
	
	/**
	 * 
	 * @param contentList
	 */
	protected void renderContentContainerHTML(contentList) {
		
		def contentSize = contentList.size()
		Random r = new Random()
		def currIdx = 0
		
		while (true) {
			
			if ((contentSize - currIdx) <= 0) {
				break
			}
			
			def columnSize
//			def type = r.nextInt(4+1)
			def type = r.nextInt(3+1) // no case 4
			switch (type) {
				case 0:
					// 12
					columnSize = 1
					def ls = contentList[currIdx..currIdx]
					render "<div class='row rowmargin'>"
					def lr = r.nextInt(2)
					render template: "contents_col", model:[content:ls[0], span:12, object_template:'content_object_table', lr: lr]
					render "</div>"
					currIdx++
					break
				case 1:
					// 7-5
					columnSize = 2
					def remainSize = contentSize - currIdx;
					if (!(columnSize > remainSize)) {
						def ls = contentList[currIdx..currIdx+1]
						render "<div class='row rowmargin'>"
						def lr = r.nextInt(2)
						render template: "contents_col", model:[content:ls[0], span:7, object_template:'content_object_table', lr: lr]
						if (lr == 1) {
							lr == 1
						} else {
							lr = r.nextInt(2)
						}
						render template: "contents_col", model:[content:ls[1], span:5, object_template:'content_object_table', lr: lr]
						render "</div>"
						currIdx+= columnSize
					}
					break
				case 2:
					columnSize = 2
					def remainSize = contentSize - currIdx;
					if (!(columnSize > remainSize)) {
						def ls = contentList[currIdx..currIdx+1]
						render "<div class='row rowmargin'>"
						def lr = r.nextInt(2)
						render template: "contents_col", model:[content:ls[0], span:5, object_template:'content_object_table', lr: lr]
						if (lr == 1) {
							lr == 1
						} else {
							lr = r.nextInt(2)
						}
						render template: "contents_col", model:[content:ls[1], span:7, object_template:'content_object_table', lr: lr]
						render "</div>"
						currIdx+= columnSize
					}
					break
				case 3:
					columnSize = 2
					def remainSize = contentSize - currIdx;
					if (!(columnSize > remainSize)) {
						def ls = contentList[currIdx..currIdx+1]
						render "<div class='row rowmargin'>"
						def lr = r.nextInt(2)
						render template: "contents_col", model:[content:ls[0], span:6, object_template:'content_object_table', lr: lr]
						if (lr == 1) {
							lr == 1
						} else {
							lr = r.nextInt(2)
						}
						render template: "contents_col", model:[content:ls[1], span:6, object_template:'content_object_table', lr: lr]
						render "</div>"
						currIdx+= columnSize
					}
					break
				case 4:
					columnSize = 3
					def remainSize = contentSize - currIdx;
					if (!(columnSize > remainSize)) {
						def ls = contentList[currIdx..currIdx+2]
						render "<div class='row rowmargin'>"
						render template: "contents_col", model:[content:ls[0], span:4, object_template:'content_object_table']
						render template: "contents_col", model:[content:ls[1], span:4, object_template:'content_object_table']
						render template: "contents_col", model:[content:ls[2], span:4, object_template:'content_object_table']
						render "</div>"
						currIdx+= columnSize
					}
					break
			}
		}
		
		if (contentSize == 0) {
			render ""
		}
	}
	
	protected void renderContentCoverBlockSquare(contentList) {
		contentList.each { content ->
			render template: "content_cover_block_square", model:[content: content]
		}
		render ""
	}

    /**
     * List all contents for currentUser
     * @return
     */
	def personal() {
		
		def channelName = getChannelName(params)
		def channel = Channel.findByName(channelName)
		
		if (channel) {
			session['channel'] = channel
		} else {
			response.sendError(404)
		}
		
		log.info "Enter personal content page, channelName is ${channelName}"
		params.channel = channelName
		
        [params:params, channel:channel]
	}
	
	def renderPersonalContentsHTML() {
		
		def channelName = getChannelName(params)
		
		log.info "Get personal contents where channel name is ${channelName}"
		
		def contentList = []
		
		if (params.q) {
			def searchResult = Content.search(params.q, [from: params.offset, size: params.max])
			searchResult.searchResults.each { result ->
				def content = Content.get(result.id)
				if (content && !content.isDelete) {
					if (content.user == springSecurityService.currentUser) {
						contentList << content
					}
				}
			}
		} else {
			def criteria = Content.createCriteria()
			contentList = criteria.list (max: params.max, offset: params.offset) {
				eq("user", springSecurityService.currentUser)
				eq("isDelete", false)
				channel {
					eq("name", channelName)
				}
				order 'datePosted', 'desc'
				order 'lastUpdated', 'desc'
			}
		}

		contentList.each { content ->
			render template: "content_object_personal", bean:content
		}
		
		render ""
	}
	
	@Transactional
	def ajaxInlineUpdate(Content contentInstance) {

        def result = [id: params.id, instance: contentInstance]

        if (!contentInstance) {
            result.hasError = true
            result.message = "Content instance ${params.id} not found."
        }

        contentInstance.properties = params

        println params
        println contentInstance.cropTitle

        if (contentInstance.validate() && contentInstance.save(flush: true)) {
            result.hasError = false
            result.message = g.formatDate(date: contentInstance.lastUpdated, type: "datetime", style: "LONG", timeStyle: "SHORT")
        }
        else {
            result.hasError = true
            result.message = renderErrors(bean: contentInstance)
        }

		//TODO
//        render result as JSON
		render template: "content_elements_personal", bean: contentInstance
    }
	
	@Transactional
	def disableContent() {
		
		def contentId = params.contentid
		
		if (contentId != null) {
			def content = Content.get(contentId)
			content.isDelete = true
			content.save flush:true
		}
		
		render ""
	}
	
	@Transactional
	def switchPrivacy() {
		
		def contentId = params.contentid
		
		if (contentId != null) {
			def content = Content.get(contentId)
			
			if (content.isPrivate) {
				content.isPrivate = false
			} else {
				content.isPrivate = true
			}
			
			content.save flush:true
			render template: "content_elements_personal", bean:content
		}
		
		render ""
	}
	
	@Transactional
    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
	def uploadImage() {

        def currentUser = springSecurityService.isLoggedIn()?springSecurityService.currentUser:User.findByUsername('anonymous')

		if (params.dataURL && params.filename) {
			S3File s3file

			String dataURL = params.dataURL

			String filename = params.filename

			String contentType = params.contentType

			String b64data = dataURL.substring(dataURL.indexOf(',') + 1)

			File tmpfile = File.createTempFile(params.filename, 's3file')

			tmpfile.withOutputStream { os ->
				os << b64data.decodeBase64()
			}

			s3file = s3Service.upload(
					currentUser,
					tmpfile,
					filename,
					contentType,
					true,
					'USER-UPLOAD-IMAGE-BY-PASTE'
			)

			tmpfile.delete()

			log.info 'S3File id: ' + s3file.id
			log.info 'S3File object key: ' + s3file.objectKey
			log.info 'S3File url: ' + s3file.url

			render s3file as JSON
			return
		}

        if (params.file) {
            CommonsMultipartFile imageFile = params.file
            if (!imageFile.isEmpty()) {

                S3File s3file = s3Service.upload(
                        currentUser,
                        imageFile,
                        true,
                        'USER-UPLOAD-IMAGE'
                )

                log.info 'S3File id: ' + s3file.id
                log.info 'S3File object key: ' + s3file.objectKey
                log.info 'S3File url: ' + s3file.url

                render s3file as JSON
                return
            }
        }

		response.sendError(404)
		//render ([] as JSON)
	}
	
	@Transactional
    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def postContent() {

//		log.info "Content ID: ${params.id}"
//		log.info "The id list of files: ${params.s3fileId}"
//		log.info "User input text: ${params.contentText}"
//		log.info "References: ${params.references}"
		
		// new content instance for persistence

        Content contentInstance

        if (params.id) {
            contentInstance = Content.get(params.id)
        }

        if (!contentInstance) {
            contentInstance = new Content()

            contentInstance.textSegments = []
            contentInstance.pictureSegments = []
            contentInstance.categories = []

            contentInstance.isDelete = false
            contentInstance.isPrivate = Boolean.parseBoolean(params.isLocked)
			
			//TODO send channel parameter
			contentInstance.channel = session['channel']
        }

        def fullText = ''
		def dataIdx = 0
		def firstSegment
		def cropSegment
		def maxLength = 0

        def pendingRemoves = []

        pendingRemoves.addAll contentInstance.textSegments
        pendingRemoves.each {
            textSegment ->
                contentInstance.removeFromTextSegments(textSegment)
                textSegment.delete flush: true
        }

        if (params.contentText) {
			
			def contentList = params.contentText.trim().split("\n\n")
			
			contentList.each { segment ->
//				log.info '' + segment
				segment = segment.trim()
				if (segment == "") { return }
				
				if (firstSegment == null) {
					firstSegment = segment;
				}
				
				if (segment.length() > maxLength) {
					cropSegment = segment;
					maxLength = segment.length()
				}
				
				def textSegment = new TextSegment(content: contentInstance, dataIndex: dataIdx, text: segment);
				contentInstance.textSegments << textSegment
				fullText+= segment + "\n\n"
				dataIdx++
			}
		}

        pendingRemoves = []
        pendingRemoves.addAll contentInstance.pictureSegments
        pendingRemoves.each {
            PictureSegment pictureSegment ->
                contentInstance.removeFromPictureSegments(pictureSegment)
                pictureSegment.delete flush: true
        }

		// Set image files for content
		def fileidList = params.s3fileId?.tokenize(",");
		dataIdx = 0
		fileidList.each { s3fileId ->
			def s3ImageFile = S3File.get(s3fileId)
			if (s3ImageFile) {
				def pictureSegment = new PictureSegment(content: contentInstance, s3File: s3ImageFile, dataIndex: dataIdx, originalUrl: s3ImageFile.unsecuredUrl, thumbnailUrl: s3ImageFile.thumbnailUrl)
				contentInstance.pictureSegments << pictureSegment
				// log.info 'Picture segment added. {' + pictureSegment + '}'
				dataIdx++
			}
		}

        // Default Cover Pictures
        if (contentInstance.pictureSegments.size() == 0) {
            // pick up default cover pictures

            def defaultCovers = S3File.findAllByRemark('DEFAULT-COVER-IMAGE')

            if (defaultCovers) {
                Random r = new Random()
                def idx = r.nextInt(defaultCovers.size())

                dataIdx = 0
                if (defaultCovers.size() > 0) {
                    def s3ImageFile = defaultCovers.get(idx)
                    def pictureSegment = new PictureSegment(
                            content: contentInstance, s3File: s3ImageFile, dataIndex: dataIdx, originalUrl: s3ImageFile.unsecuredUrl, thumbnailUrl: s3ImageFile.thumbnailUrl
                    )
                    contentInstance.pictureSegments << pictureSegment
                    // log.info 'Picture segment added. {' + pictureSegment + '}'
                    dataIdx++
                }
            }
        }

        // remove existing categories
        pendingRemoves = []
        pendingRemoves.addAll contentInstance.categories
        pendingRemoves.each {
            contentInstance.removeFromCategories it
        }

		// add multi-category
		def categoryTokens = params.categorysData?.tokenize(",")
		categoryTokens.each { name ->
			def category = Category.findByName(name)
			contentInstance.categories << category
		}

        // Don't replace exists cropTitle
        if (!contentInstance.cropTitle) {
			def cropTitle = contentService.cropTitle(firstSegment)
			log.info 'Cropped title: ' + cropTitle
			
			cropTitle = cropTitle.replaceAll("#", "").replaceAll("\\*", "")
			contentInstance.cropTitle = cropTitle
        }

        // Don't replace exists cropText
        if (!contentInstance.cropText) {
            contentInstance.cropText = cropSegment
        }

        // Always replace fullText
		contentInstance.fullText = fullText

        // Set content location
        if (params.lat && params.lon) {

            log.info "Setup content location (${params.lat}, ${params.lon})"

            // Set geo location
            if (!contentInstance.location) {
                contentInstance.location = new GeoPoint()
            }

            contentInstance.location.lat = Float.parseFloat(params.lat)
            contentInstance.location.lon = Float.parseFloat(params.lon)

            contentInstance.location.save flush: true
        }

        // Set cover image
		if (contentInstance.pictureSegments) {
            def firstImage = contentInstance.pictureSegments.first()
			contentInstance.coverUrl = firstImage.thumbnailUrl? firstImage.thumbnailUrl: firstImage.originalUrl
            log.info "Set coverUrl = ${contentInstance.coverUrl}"
        }

		contentInstance.hasPicture = contentInstance.pictureSegments? true: false

        //TODO set as anonymous user if not logged in
        if (!contentInstance.user) {
            contentInstance.user = springSecurityService.isLoggedIn()? springSecurityService.currentUser: User.findByUsername('anonymous')
        }

		contentInstance.template = matchTemplate(contentInstance)

        if (!contentInstance.references) {
            contentInstance.references = params.references
        }

        contentInstance.isShowLocation = params.getBoolean('isShowLocation')
		
		// set trading value for the content of trade channel
		if (params.tradingValue) {
			if (contentInstance.tradingContentAttribute) {
				contentInstance.tradingContentAttribute.price = params.tradingValue as double
			} else {
				log.info 'Adding new trading attribute object'
				def tradingContentAttribute = new TradingContentAttribute(price: params.tradingValue as double)
				contentInstance.tradingContentAttribute = tradingContentAttribute
			}
		}

		contentInstance.validate()
		log.info contentInstance.errors
		
		// save content
		contentInstance.save flush: true

        session.setAttribute(KglConstant.SESSION_KEY_LATEST_CONTENT_ID, contentInstance.id)
		
		render contentInstance as JSON
	}

    private OriginalTemplate matchTemplate(Content content) {
		
		//TODO match template by channel
		
		if (content.pictureSegments == null) {
			return OriginalTemplate.defaultTemplate
		}
		
		def templates
		
		if (content.channel?.name.equals(grailsApplication.config.grails.application.default_channel)) {
			int mediaCount = content.pictureSegments.size()
			templates = OriginalTemplate.findAllByGroupingAndMediaCount('default', mediaCount)
		} else {
			templates = OriginalTemplate.findAllByGrouping(content.channel.name)
		}

        if (!templates) {
			// gsp-default will show all text and pictures
            return OriginalTemplate.defaultTemplate
        }
		
		log.info 'Number of templates can be selected: ' + templates.size()
		Random r = new Random()
		def idx = r.nextInt(templates.size())
		def template = templates.get(idx)
		log.info 'Template name: ' + template.name + ' type: ' + template.renderType + ' be selected'
		
        return template
    }

    @Secured(["ROLE_ADMIN"])
    def debug() {
        render Content.list() as JSON
    }

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def shorten() {
        def contentId = session.getAttribute(KglConstant.SESSION_KEY_LATEST_CONTENT_ID)

        if (!contentId) {
            redirect uri: '/'
            return
        }
		
		def content = Content.get(contentId)
		
		def checkAction = checkContent(content)
		if (checkAction) {
			redirect action: checkAction
		} else {
			def hashcode = contentService.createEditableHashcode(content)
			
			def updateFlag = false;
			if (params.updateTitle) {
				updateFlag = true;
				content.cropTitle = params.updateTitle
			}
			if (params.updateDesc) {
				updateFlag = true;
				content.cropText = params.updateDesc
			}
			if (params.updateReference) {
				updateFlag = true;
				content.references = params.updateReference
			}
			if (updateFlag) {
				content.save flush: true
			}
			
			def channel = content.channel
			params.channel = channel.name
	
			[contentId: contentId, hashcode: hashcode, content: content, channel: channel, params: params]
		}
    }

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def ajaxSendShortenMail(Content content) {

        def toAddress = params.to

        content.ownerEmail = toAddress
        content.save flush: true

        sendMail {
            to toAddress
            subject "[E7READ] ${content.cropTitle}"
            body """${createLink(controller: 'content', action: 'modifyByHash', params: [hash: content.editableHashcode], absolute: true)}"""
        }

        def result = [
                result: true
        ]

        render result as JSON
    }

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def mail(Content contentInstance) {


        respond contentInstance
    }
	
	@Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
	def disableByHashcode() {
		def content = Content.findByEditableHashcode(params.id)
		content.isDelete = true
		content.save flush:true
		redirect action: 'deteted'
	}
	
	/**
	 * check if content deleted or locked
	 * @param content
	 * @return
	 */
	protected checkContent(Content content) {
		def action
		if (content.isDelete) {
			action = 'deteted'
		} else if (content.isPrivate && (content.user != springSecurityService.currentUser)) {
			action = 'locked'
		}
	}

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def searchByLocation() {

        double lat, lon

        if (session['geolocation']) {
            lat = session['geolocation'].lat?.toDouble()
            lon = session['geolocation'].lon?.toDouble()
        }

        if (lat == null || lon == null) {
            lat = message(code: 'default.location.lat').toDouble()
            lon = message(code: 'default.location.lon').toDouble()
        }

        if (params.center) {
            def latlon = params.center.split(',')

            lat = Double.parseDouble(latlon[0])
            lon = Double.parseDouble(latlon[1])
        }

        log.info "Search contents ${lat}, ${lon} distance 30km, filter by channel = ${params.channel}, category = ${params.category}"

        def channel = Channel.findByName(params.channel)
        def category = Category.findByChannelAndName(channel, params.category)

        log.info "Filter by channel = ${channel?.name}, category = ${category?.name}"

        Closure query

        // Still has problems with query filter.
//        query = {
//            //term('cropTitle': 'e7read title')
//            bool {
//                must {
//                    query_string(query: "channel.name:${channel?.name?:'*'}")
//                    //term (cropTitle: '*title')
//                }
//            }
//        }
        query = null as Closure

        Closure filter = {
            geo_distance(
                    'distance': '30km',
                    'location': [lat: lat, lon: lon]
            )
        }

        def sortBuilder = SortBuilders.
                geoDistanceSort("location").
                point(lat, lon).
                unit(DistanceUnit.KILOMETERS).
                order(SortOrder.ASC)

        Map searchParams = [
                indices: Content,
                types: Content,
                sort: sortBuilder
        ]

        def result = elasticSearchService.search(searchParams, query, filter)

        def contents = []

        result.searchResults.each {

            //log.info "Process search result: ${it.id}"

            def content = Content.get(it.id)

            if (content && content.channel?.equals(channel)) {
                if (!category || content.categories?.contains(category)) {
                    //if (content) {
                    contents << [
                            cropTitle: content.cropTitle,
                            cropText: content.cropText,
                            location: [lat: content.location?.lat, lon: content.location?.lon],
                            shareUrl: createLink(controller: 'content', action: 'share', id: content.id, absolute: true),
                            coverUrl: content.coverUrl,
                            channel: content.channel?.name
                    ]
                }
            }
        }
        render contents as JSON
    }
	
	/**
	 * Get channel name
	 * @param params
	 * @return
	 */
	protected String getChannelName(params) {
		
		def channelName
		
		if (params.channel) {
			channelName = params.channel
		} else {
			channelName = grailsApplication.config.grails.application.default_channel
		}
		
		return channelName
	}

    def updateLocation(Content content) {
        //todo: check user permission

        if (!content) {
            response.sendError(404)
            return
        }

        if (!content.location) {
            content.location = new GeoPoint()
        }

        content.location.lat = Double.parseDouble(params.lat)
        content.location.lon = Double.parseDouble(params.lon)

        content.location.save flush: true

        content.save flush: true

        render content.location as JSON
    }
	
	
	@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def getContentViewHTML() {
		
		def id = params.id;
		def content = Content.get(id);
		
		
		loggingService.addReadingLog(
			session? session.id: null, 
			request.getHeader("User-Agent"), 
			springSecurityService.currentUser? springSecurityService.currentUser.id: null, 
			content.channel.id, 
			content.id)
		
		
		if (params.channel == 'e7read') {
			render template: "/content/view/content_view_traditional", model: [content: content]
		} else {
			render template: "/content/view/content_view_trading", model: [content: content]
		}
	}
	
	def distributeBookContent() {
		
		log.info params

		def categoryId = params.categoryId		
		def cropTitle = params.cropTitle
		def cropText = params.cropText
		def fullText = params.cropText
		
		def bookId = params.bookId
		def book
		
		if (bookId) {
			book = Book.get(bookId)
		}
		
		if (book) {
			
			def content = new Content()
			
			content.bookContentAttribute = new BookContentAttribute()
			content.bookContentAttribute.book = book
			content.type = 'EBOOK'
			
			content.cropTitle = cropTitle
			content.cropText = cropText
			content.fullText = fullText
			
			content.hasPicture = false
			content.isPrivate = false
			content.isDelete = false
			content.isShowContact = false
			content.isShowLocation = false
			
			// distribute content to default channel
			content.channel = Channel.findByIsDefault(true)
			content.categories = []
			
			content.categories << Category.get(categoryId)
			
			if (springSecurityService.currentUser) {
				content.user = springSecurityService.currentUser
			} else {
				content.user = User.findByUsername('admin')
			}
			
			def hql = """
				select page from Page as page where page.book.id = :bookId order by dataIndex
			"""
			def pages = Page.executeQuery(hql, [bookId: bookId], [max: 1, offset: 0])
			if (pages.size() == 1) {
				def page = pages.getAt(0)
				content.coverUrl = s3Service.generatePresignedUrl(page.bucket, page.imageKey)
			}
			
			content.save flush: true
			
			def redirectAction = ""
			if (session?.bookAdminNavigation?.prevAction) {
				redirectAction = '/bookAdmin/' + session?.bookAdminNavigation?.prevAction
			} else {
				redirectAction = '/bookAdmin/index'
			}
			
			def redirectParams = [:]
			session?.bookAdminNavigation?.params.each { key, value ->
				if (value) {
					redirectParams[key] = value
				}
			}
			
			redirect uri: redirectAction, params: redirectParams
			
		} else {
		
			return response.sendError(404)
		}
	}
	
	
}
