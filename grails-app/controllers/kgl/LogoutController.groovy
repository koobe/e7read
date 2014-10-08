package kgl

import javax.swing.text.html.HTML;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler

import grails.plugin.springsecurity.SpringSecurityUtils;
import groovyx.net.http.HTTPBuilder

class LogoutController {
	
	def grailsApplication

    def index() {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth) {
			new SecurityContextLogoutHandler().logout(request, response, auth)
		}
		SecurityContextHolder.getContext().setAuthentication(null)
		
		// if redirect to...
		if (params.channel) {
			redirect uri: "/${params.channel}"
		} else {
			redirect uri: "/"
		}
	}
}
