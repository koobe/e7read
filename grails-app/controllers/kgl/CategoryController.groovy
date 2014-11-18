package kgl

import grails.converters.JSON
import grails.converters.XML
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
@Secured(["ROLE_ADMIN"])
class CategoryController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def grailsApplication

    def categoryService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Category.list(params), model:[categoryInstanceCount: Category.count()]
    }

    def export() {
        render Category.list() as JSON
    }

    def show(Category categoryInstance) {
        respond categoryInstance
    }

    def create() {
        respond new Category(params)
    }

    @Transactional
    def save(Category categoryInstance) {
        if (categoryInstance == null) {
            notFound()
            return
        }

        if (categoryInstance.hasErrors()) {
            respond categoryInstance.errors, view:'create'
            return
        }

        categoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.id])
                redirect categoryInstance
            }
            '*' { respond categoryInstance, [status: CREATED] }
        }
    }

    def edit(Category category) {
        respond category
    }

    @Transactional
    def update(Category categoryInstance) {
        if (categoryInstance == null) {
            notFound()
            return
        }

        if (categoryInstance.hasErrors()) {
            respond categoryInstance.errors, view:'edit'
            return
        }

        categoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Category.label', default: 'Category'), categoryInstance.id])
                redirect categoryInstance
            }
            '*'{ respond categoryInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Category categoryInstance) {

        if (categoryInstance == null) {
            notFound()
            return
        }

        categoryInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Category.label', default: 'Category'), categoryInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
	@Deprecated
	@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def addCategoryMenu() {
//		def categoryList = Category.findAllByCategory(null)
//		render template: "category_panel_topmenu", model:[categorys: categoryList, active: params.c]
	}
	
	@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def addCategoryPanel() {
		
		def channelName = getChannelName(params)
		
		log.info "channelName = ${channelName}"

		def categoryList = categoryService.list(channelName)
		
		render template: "category_panel_sidemenu", model:[categorys: categoryList, active: params.c, showpanel: params.p, btnaction: params.btnaction]
	}
	
	@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def addUIComponentCategoriesRankOnTop() {
		
		def channelName = getChannelName(params)
		
		def hql = """
				select category 
				from Category as category
				where rankOnTop is not null and enable = true and channel.name = :channelName
				order by rankOnTop asc
			"""
		def categoryList = Category.executeQuery(hql, [channelName: channelName])

		render template: "category_panel_rankontop", model: [categories: categoryList, activeCategoryName: params.c]
	}
	
	protected String getChannelName(params) {
		
		def channelName
		
		if (params.channel) {
			channelName = params.channel
		} else {
			log.info "Goto default channel"
			channelName = grailsApplication.config.grails.application.default_channel
		}
		
		return channelName
	}
}
