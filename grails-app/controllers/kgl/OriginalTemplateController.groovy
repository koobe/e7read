package kgl

import grails.converters.JSON
import grails.converters.XML
import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OriginalTemplateController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond OriginalTemplate.list(params), model:[originalTemplateInstanceCount: OriginalTemplate.count()]
    }

    def show(OriginalTemplate originalTemplateInstance) {
        respond originalTemplateInstance
    }

    def create() {
        respond new OriginalTemplate(params)
    }

    @Transactional
    def save(OriginalTemplate originalTemplateInstance) {
        if (originalTemplateInstance == null) {
            notFound()
            return
        }

        if (originalTemplateInstance.hasErrors()) {
            respond originalTemplateInstance.errors, view:'create'
            return
        }

        originalTemplateInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'originalTemplate.label', default: 'OriginalTemplate'), originalTemplateInstance.id])
                redirect originalTemplateInstance
            }
            '*' { respond originalTemplateInstance, [status: CREATED] }
        }
    }

    def edit(OriginalTemplate originalTemplateInstance) {
        respond originalTemplateInstance
    }

    @Transactional
    def update(OriginalTemplate originalTemplateInstance) {
        if (originalTemplateInstance == null) {
            notFound()
            return
        }

        if (originalTemplateInstance.hasErrors()) {
            respond originalTemplateInstance.errors, view:'edit'
            return
        }

        originalTemplateInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'OriginalTemplate.label', default: 'OriginalTemplate'), originalTemplateInstance.id])
                redirect originalTemplateInstance
            }
            '*'{ respond originalTemplateInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(OriginalTemplate originalTemplateInstance) {

        if (originalTemplateInstance == null) {
            notFound()
            return
        }

        originalTemplateInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'OriginalTemplate.label', default: 'OriginalTemplate'), originalTemplateInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'originalTemplate.label', default: 'OriginalTemplate'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(["ROLE_ADMIN"])
    def debug() {
        withFormat {
            html {
                render OriginalTemplate.findByName('default').html
            }
            json {
                render OriginalTemplate.list() as JSON
            }
            xml {
                render OriginalTemplate.list() as XML
            }
        }
    }
}
