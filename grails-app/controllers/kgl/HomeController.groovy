package kgl

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(["permitAll"])
class HomeController {
	
    def s3Service

    def index() {}

    def hasBucket() {
        //render "GString ${params.name}"

        render "${s3Service.doesBucketExist(params.name)}"
        //render  as JSON
    }
}
