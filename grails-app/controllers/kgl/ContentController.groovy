package kgl

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.springframework.web.multipart.commons.CommonsMultipartFile

import static org.springframework.http.HttpStatus.*

@Secured(["ROLE_USER"])
@Transactional
class ContentController {

	def grailsApplication
    def springSecurityService
    def templateService
    def s3Service
    def contentService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 5, 100)
		def datas = Content.list(params)
		println params.max
        respond datas, model:[contentInstanceCount: Content.count()]
    }

    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def show(Content contentInstance) {
//        respond contentInstance

        if (!contentInstance) {
            notFound()
            return
        }

		//TODO FOR TEST
		[
			content: contentInstance
        ]
    }

    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def embed(Content contentInstance) {

        def template = OriginalTemplate.get(params.template?.id)

        def output

        if (!template) {
            output = templateService.render(contentInstance)
        }
        else {
            output = templateService.render(contentInstance, template)
        }

        //render contentInstance.fullText.replaceAll("\n\n", "<br/><br/>")

        render contentType: 'text/html', text: output
    }

    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def create() {
        respond new Content(params)
    }

    @Transactional
    def save(Content contentInstance) {

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

        respond contentInstance
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

        respond content
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
		
		if (params.q) {
			log.info 'search content: {' + params.q + '}'
			def searchResult = Content.search(params.q, [from: params.from, size: params.size])
			searchResult.searchResults.each { result ->
				def content = Content.get(result.id)
				if (content && !content.isDelete && !content.isPrivate) {
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
				where category.name in (:categories) and content.isDelete = false and content.isPrivate = false
				order by content.datePosted desc, content.lastUpdated desc
				"""
				contentList = Content.executeQuery(hql, [categories: categoryList], [max: params.max, offset: params.offset])
			}
		} else if (params.u) {
			def hql = """
				select content 
				from Content as content
				where content.user.id = :userId and content.isDelete = false and content.isPrivate = false
				order by content.datePosted desc, content.lastUpdated desc
			"""
			def u = new Long(params.u)
			contentList = Content.executeQuery(hql, [userId: u], [max: params.max, offset: params.offset])
		} else {
			def criteria = Content.createCriteria()
			contentList = criteria.list (max: params.max, offset: params.offset) {
				eq 'isDelete', false
				eq 'isPrivate', false
				order 'datePosted', 'desc'
				order 'lastUpdated', 'desc'
			}
		}

		renderContentContainerHTML(contentList)
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

    /**
     * List all contents for currentUser
     * @return
     */
	def personal() {
        []
	}
	
	def renderPersonalContentsHTML() {
		
		def contentList = []
		
		if (params.q) {
			def searchResult = Content.search(params.q, [from: params.from, size: params.size])
			searchResult.searchResults.each { result ->
				def content = Content.get(result.id)
				if (content && !content.isDelete && !content.isPrivate) {
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
				order 'datePosted', 'desc'
				order 'lastUpdated', 'desc'
			}
		}
		
		// def contentList = Content.findAllByUser(springSecurityService.currentUser, [max: params.max, offset: params.offset, sort: "lastUpdated", order: "desc"]);

        // Return nothing if no any contents
        if (!contentList) {
            render ""
            return
        }
		
		def currItem = 1
		def hasEndDiv = false
		
		contentList.each { content ->
			
//			if (currItem.mod(2) != 0) {
//				render '<div class="row rowmargin">'
//				hasEndDiv = false
//			}
			
			// render template: "contents_col", model:[content:content, span:6, object_template:'content_object_personal']
			render template: "content_object_personal", bean:content
			
//			if (currItem.mod(2) == 0) {
//				render "</div>"
//				hasEndDiv = true
//			}
			
			currItem++
		}
		
//		if (contentSize != 0 && !hasEndDiv) {
//			render "</div>"
//		}
		

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
			content.isDelete = true;
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

		List<CommonsMultipartFile> imageFiles = params.list("file")
		imageFiles.each { imageFile ->
			if (!imageFile.isEmpty()) {

				S3File s3file

                s3file = s3Service.upload(
                        currentUser,
                        imageFile,
                        imageFile.inputStream,
                        true,
                        'USER-UPLOAD-IMAGE'
                )

				log.info 'S3File id: ' + s3file.id
				log.info 'S3File object key: ' + s3file.objectKey
				log.info 'S3File url: ' + s3file.url
				
				render s3file as JSON
			}
		}

		render ""
	}
	
	@Transactional
    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def postContent() {

        log.info "Content ID: ${params.id}"
		log.info "The id list of files: ${params.s3fileId}"
		log.info "User input text: ${params.contentText}"
		log.info "References: ${params.references}"
		
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
        }

        def fullText = ''
		def dataIdx = 0
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
			
			def contentList = params.contentText.trim().split("\n")
			
			contentList.each { segment ->
				log.info '' + segment
				
				segment = segment.trim()
				if (segment == "") { return }
				
				if (segment.length() > maxLength) {
					cropSegment = segment.trim();
					maxLength = segment.length()
				}
				
				def textSegment = new TextSegment(content: contentInstance, dataIndex: dataIdx, text: segment.trim());
				contentInstance.textSegments << textSegment
				fullText+= segment.trim() + "\n\n"
				dataIdx++
			}
		}

        pendingRemoves = []
        pendingRemoves.addAll contentInstance.pictureSegments
        pendingRemoves.each {
            PictureSegment pictureSegment ->
                //pictureSegment.delete flush: true
                contentInstance.removeFromPictureSegments(pictureSegment)
                pictureSegment.delete flush: true
        }

		// Set image files for content
		def fileidList = params.s3fileId?.tokenize(",");
		dataIdx = 0
		fileidList.each { s3fileId ->
			def s3ImageFile = S3File.get(s3fileId)
			def pictureSegment = new PictureSegment(content: contentInstance, s3File: s3ImageFile, dataIndex: dataIdx, originalUrl: s3ImageFile.unsecuredUrl)
			contentInstance.pictureSegments << pictureSegment
			// log.info 'Picture segment added. {' + pictureSegment + '}'
			dataIdx++
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
                    def pictureSegment = new PictureSegment(content: contentInstance, s3File: s3ImageFile, dataIndex: dataIdx, originalUrl: s3ImageFile.unsecuredUrl)
                    contentInstance.pictureSegments << pictureSegment
                    // log.info 'Picture segment added. {' + pictureSegment + '}'
                    dataIdx++
                }
            }

        }

        pendingRemoves = []
        pendingRemoves.addAll contentInstance.categories
        pendingRemoves.each {
            contentInstance.removeFromCategories it
            //it.delete flush: true
        }

		// add multi-category
		def categoryTokens = params.categorysData?.tokenize(",")
		categoryTokens.each { name ->
			def category = Category.findByName(name)
			contentInstance.categories << category
		}
		
//		def categoryName = categorys?.first()
//		if (categoryName) {
//			log.info 'add category: ' + categoryName
//			def category = Category.findByName(categoryName)
//			contentInstance.category = category
//		}

        // Don't replace exists cropTitle and cropText
        if (!contentInstance.cropTitle) {
            contentInstance.cropTitle = fullText?.trim().split("\n").first().split(",|\\.|;|，|。").first().trim()
        }
        if (!contentInstance.cropText) {
            contentInstance.cropText = cropSegment
        }

		contentInstance.fullText = fullText

		if (contentInstance.pictureSegments) {
			contentInstance.coverUrl = contentInstance.pictureSegments.first().thumbnailUrl? contentInstance.pictureSegments.first().thumbnailUrl: contentInstance.pictureSegments.first().originalUrl
		}

		contentInstance.hasPicture = contentInstance.pictureSegments? true: false
		contentInstance.isDelete = false
		contentInstance.isPrivate = false

        //TODO set as anonymous user if not logged in
        contentInstance.user = springSecurityService.isLoggedIn()?springSecurityService.currentUser:User.findByUsername('anonymous')

		contentInstance.template = matchTemplate(contentInstance)

		contentInstance.references = params.references

		contentInstance.validate()
		log.info contentInstance.errors
		
		contentInstance.save flush: true

        session.setAttribute(MyConstant.SESSION_KEY_LATEST_CONTENT_ID, contentInstance.id)
		
		render contentInstance as JSON
	}
	
//	@Transactional
//	def postContent() {
//		
//		log.info "The id list of files: ${params.s3fileId}"
//		log.info "User input text: ${params.contentText}"
//		log.info "References: ${params.references}"
//
//		// parse content as xml
//		def contentXml = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "' + grailsApplication.config.grails.serverURL + '/assets/xhtml1-transitional.dtd">' +
//			"<html>" + params.contentText + "</html>"
//			
//		contentXml = contentXml.replaceAll("<br[^>]*>", "<br/>")
//		log.info 'Mock xml: ' + contentXml
//		
//		def parser = new XmlParser()
//		parser.setFeature("http://apache.org/xml/features/disallow-doctype-decl", false)
//		def contentDom = parser.parseText(contentXml)
//		
//		// new content instance for persistence
//		def contentInstance = new Content()
//		contentInstance.textSegments = []
//		contentInstance.pictureSegments = []
//		
//		def fullText = ''
//		def dataIdx = 0
//		def cropSegment
//		def maxLength = 0
//		contentDom.children().each { node ->
//			
//			String segment;
//			if (node instanceof String) {
//				segment = node;
//			} else if (node instanceof Node) {
//				segment = node.text()
//			} else {
//				log.warn 'Unknow node type: ' + node;
//				return
//			}
//			
//			// log.info 'segment data: ' + segment
//			segment = segment.replaceAll("&nbsp;", " ");
//			segment = segment.replaceAll(String.valueOf((char) 160), " ")
//			
//			// break if no data
//			segment = segment.trim()
//			if (segment == "") {
//				return
//			}
//			// log.info 'after trim segment data: ' + segment
//
//			if (segment.length() > maxLength) {
//				cropSegment = segment.trim();
//				maxLength = segment.length()
//			}
//			
//			def textSegment = new TextSegment(content: contentInstance, dataIndex: dataIdx, text: segment.trim());
//			contentInstance.textSegments << textSegment
//			fullText+= segment.trim() + "\n\n"
//			dataIdx++
//		}
//		
//		// Set image files for content
//		def fileidList = params.s3fileId.tokenize(",");
//		dataIdx = 0
//		fileidList.each { s3fileId ->
//			def s3ImageFile = S3File.get(s3fileId)
//			def pictureSegment = new PictureSegment(content: contentInstance, s3File: s3ImageFile, dataIndex: dataIdx, originalUrl: s3ImageFile.unsecuredUrl)
//			contentInstance.pictureSegments << pictureSegment
//			// log.info 'Picture segment added. {' + pictureSegment + '}'
//			dataIdx++
//		}
//		
//		contentInstance.cropTitle = fullText?.trim().split("\n").first().split(",|\\.|;|，|。").first().trim()
//		contentInstance.cropText = cropSegment
//		contentInstance.fullText = fullText
//
//		if (contentInstance.pictureSegments) {
//			contentInstance.coverUrl = contentInstance.pictureSegments.first().thumbnailUrl? contentInstance.pictureSegments.first().thumbnailUrl: contentInstance.pictureSegments.first().originalUrl
//		}
//
//		contentInstance.hasPicture = contentInstance.pictureSegments? true: false
//		contentInstance.isDelete = false
//		contentInstance.isPrivate = false
//
//		contentInstance.user = springSecurityService.currentUser
//
//		contentInstance.template = matchTemplate(contentInstance)
//
//        contentInstance.references = params.references
//
//		contentInstance.validate()
//		log.info contentInstance.errors
//		
//		contentInstance.save(flush: true)
//		
//		render ""
//	}

    private OriginalTemplate matchTemplate(Content content) {
        if (content.pictureSegments == null) {
            return null
        }

        int mediaCount = content.pictureSegments.size()

        def templates = OriginalTemplate.findAllByGroupingAndMediaCount('default', mediaCount)

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
        def contentId = session.getAttribute(MyConstant.SESSION_KEY_LATEST_CONTENT_ID)

        if (!contentId) {
            redirect uri: '/'
            return
        }

        def hashcode = contentService.createEditableHashcode(Content.get(contentId))

        [contentId: contentId, hashcode: hashcode]
    }
}
