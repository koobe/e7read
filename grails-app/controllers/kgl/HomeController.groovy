package kgl

import org.hibernate.annotations.NotFound;

import grails.plugin.springsecurity.annotation.Secured

@Secured(["permitAll"])
class HomeController {
	
	def grailsApplication

    def index(String channel) {
		
		log.info 'Content channel: ' + params.channel
		
		def myChannel
		if (channel) {
			myChannel = Channel.findByName(channel)
			if (!myChannel) {
				return response.sendError(404)  
			}
		} else {
			myChannel = Channel.findByIsDefault(true)
		}
		
		//def defaultChannel = grailsApplication.config.grails.application.default_channel
		
		session['channel'] = myChannel
		params.channel = myChannel.name
		session['redirect_logged'] = "/${myChannel.name}"
		
		[params: params, channel: myChannel]
	}
}
