package kgl

import org.jsoup.Jsoup

import static org.springframework.http.HttpStatus.*

import java.awt.GraphicsConfiguration.DefaultBufferCapabilities;

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

import org.codenarc.rule.braces.ElseBlockBracesAstVisitor;
import org.springframework.web.multipart.commons.CommonsMultipartFile

@Secured(["ROLE_USER"])
@Transactional(readOnly = true)
class ContentController {

    def springSecurityService
    def s3Service

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 5, 100)
		def datas = Content.list(params)
		println params.max
        respond datas, model:[contentInstanceCount: Content.count()]
    }

    def show(Content contentInstance) {
        respond contentInstance
    }

    def embed(Content contentInstance) {

        def fullText = contentInstance.fullText?.replace("\r", "")

        def texts = fullText?.split("\n\n")

        def doc = Jsoup.parse(contentInstance.originalTemplate?.html)

        int index = 0

        println texts.length

        texts.each {
            text ->

                doc.select(".text-segment[data-index=${index}]").html(text)

                index ++
        }


        def result = doc.html()

        render contentType: 'text/html', text: result
//        render contentInstance.fullText
    }

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
        contentInstance.originalTemplate = OriginalTemplate.findByName("default")

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

    def edit(Content contentInstance) {
        respond contentInstance
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
		
	}
	
	@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def renderContentsHTML() {
				
		def criteria = Content.createCriteria()
		def contentList = criteria.list (max: params.max, offset: params.offset, sort: "lastUpdated", order: "desc") {
			eq("isDelete", false)
			eq("isPrivate", false)
		}
		
		// def contentList = Content.list(max: params.max, offset: params.offset, sort:'lastUpdated', order:'desc')
		def contentSize = contentList.size()
		Random r = new Random()
		def currIdx = 0
		
		while (true) {
			
			if ((contentSize - currIdx) <= 0) {
				break
			}
			
			def columnSize
			def type = r.nextInt(4+1)
			switch (type) {
				case 0:
					// 12
					columnSize = 1
					def ls = contentList[currIdx..currIdx]
					render "<div class='row rowmargin'>"
					render template: "contents_col", model:[content:ls[0], span:12, object_template:'content_object']
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
						render template: "contents_col", model:[content:ls[0], span:7, object_template:'content_object']
						render template: "contents_col", model:[content:ls[1], span:5, object_template:'content_object']
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
						render template: "contents_col", model:[content:ls[0], span:5, object_template:'content_object']
						render template: "contents_col", model:[content:ls[1], span:7, object_template:'content_object']
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
						render template: "contents_col", model:[content:ls[0], span:6, object_template:'content_object']
						render template: "contents_col", model:[content:ls[1], span:6, object_template:'content_object']
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
						render template: "contents_col", model:[content:ls[0], span:4, object_template:'content_object']
						render template: "contents_col", model:[content:ls[1], span:4, object_template:'content_object']
						render template: "contents_col", model:[content:ls[2], span:4, object_template:'content_object']
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

	def personal() {		
	}
	
	def renderPersonalContentsHTML() {
		
		def criteria = Content.createCriteria()
		def contentList = criteria.list (max: params.max, offset: params.offset, sort: "lastUpdated", order: "desc") {
			eq("user", springSecurityService.currentUser)
			eq("isDelete", false)
		}
		
		// def contentList = Content.findAllByUser(springSecurityService.currentUser, [max: params.max, offset: params.offset, sort: "lastUpdated", order: "desc"]);
		def contentSize = contentList.size()
		
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
		
		if (contentSize == 0) {
			render ""
		}
	}
	
	def updateTitle() {
		
		def contentId = params.contentid
		def title = params.title
		
		if (contentId != null) {
			def content = Content.get(contentId)
			content.cropTitle = title;
			content.save flush:true
			render g.formatDate(date: content.lastUpdated, type: "datetime", style: "LONG", timeStyle: "SHORT")
		}
		
		render ""
	}
	
	def disableContent() {
		
		def contentId = params.contentid
		
		if (contentId != null) {
			def content = Content.get(contentId)
			content.isDelete = true;
			content.save flush:true
		}
		
		render ""
	}
	
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

    @Secured(["ROLE_ADMIN"])
    def debug() {
        render Content.list() as JSON
    }
}
