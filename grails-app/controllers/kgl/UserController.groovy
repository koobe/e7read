package kgl

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import groovy.json.JsonParser

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional
class UserController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond User.list(params), model:[userInstanceCount: User.count()]
    }

    def show(User userInstance) {
        respond userInstance
    }

    def create() {
        respond new User(params)
    }

    @Secured(["ROLE_USER"])
    def profile() {
	
		
        def user = springSecurityService.currentUser

        def avatar = null

        if (user?.facebookId) {
            log.info "user.facebookId = ${user.facebookId}"

            avatar = "http://graph.facebook.com/${user.facebookId}/picture?type=large"

            //avatar = Facebook
        }

        [user: user, params: params, channel: session['channel'], avatar: avatar]
    }

    @Secured(["ROLE_USER"])
    def modify() {
        def user = springSecurityService.currentUser

        [user: user]
    }

    @Secured(["ROLE_USER"])
    def modifySave() {

        def user = springSecurityService.currentUser

        def userInstance = User.get(user.id)

        userInstance.properties = params

        if (!userInstance.location) {
            userInstance.location = new GeoPoint();
        }

        if (params.lat && params.lon) {
            log.info "Update user location (${params.lat}, ${params.lon})"
            userInstance.location.lat = Float.parseFloat(params.lat)
            userInstance.location.lon = Float.parseFloat(params.lon)
            userInstance.location.save flush: true
        }

        if (userInstance.validate()) {
            userInstance.save flush: true
        }

        redirect action: 'profile'
    }

    @Transactional
    def save(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'create'
            return
        }

        userInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*' { respond userInstance, [status: CREATED] }
        }
    }

    def edit(User userInstance) {
        respond userInstance
    }

    @Transactional
    def update(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'edit'
            return
        }

        userInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*'{ respond userInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        userInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(["ROLE_USER"])
    def debug() {

        def result = [:]

        result << [user: springSecurityService.currentUser]

        //result << [fbUser: FacebookUser.list()]

        render result as JSON
    }

    @Secured(["ROLE_ADMIN"])
    def location() {
        def users = User.list()

        def result = [:]

        users.each {
            result << ["${it.username}": "${it.location?.lat},${it.location?.lon}"]
        }

        render result
    }
	
	@Secured(["ROLE_USER"])
	def setLocation() {
		
		def lat = params.lat as double
		def lon = params.lon as double
		
		def user = springSecurityService.currentUser
		
		if (user.location) {
			user.location.lat = lat;
			user.location.lon = lon;
		} else {
			def geoPoint = new GeoPoint(lat: lat, lon: lon)
			user.location = geoPoint;
			geoPoint.save flush: true
		}
		
		user.save flush: true
		
		render [:] as JSON
	}
	
	@Secured(["ROLE_USER"])
	def getLocation() {
		
		def user = springSecurityService.currentUser
		
		def result = [:]
		
		result.lat = user.location?.lat
		result.lon = user.location?.lon
		result.name = user.location?.getLocationName()
		
		render result as JSON
	}
	
	@Secured(["ROLE_USER"])
	def skipSetLocation() {
		session['skipSetLocation'] = true
		render [:] as JSON
	}
}
