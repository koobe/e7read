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
	
	@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def addCategoryMenu() {
		def categoryList = Category.findAllByCategory(null)
		render template: "category_panel_topmenu", model:[categorys: categoryList, active: params.c]
	}
	
	@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def addCategoryPanel() {
		def criteria = Category.createCriteria()
		def categoryList = criteria.list () {
			eq 'enable', true
			isNull 'category'
			order 'order', 'asc'
		}
		
		render template: "category_panel_sidemenu", model:[categorys: categoryList, active: params.c, showpanel: params.p, btnaction: params.btnaction]
	}
	
	@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
	def addUIComponentCategoriesRankOnTop() {
//		def hql = 'select Category from Category c where rankOnTop is not null order by rankOnTop'
//		def categoryList = Category.executeQuery(hql)
		
		def criteria = Category.createCriteria()
		def categoryList = criteria.list () {
			isNotNull 'rankOnTop'
			eq 'enable', true
			order 'rankOnTop', 'asc'
		}
		
		render template: "category_panel_rankontop", model:[categories: categoryList, active: params.c]
	}
}
