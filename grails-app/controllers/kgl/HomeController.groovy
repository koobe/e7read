package kgl

import org.codenarc.rule.braces.ElseBlockBracesAstVisitor;
import org.hibernate.annotations.NotFound;

import grails.plugin.springsecurity.annotation.Secured

@Secured(["permitAll"])
class HomeController {
	
	def grailsApplication
	
	def springSecurityService

    def index(String channel) {
		
		if (session.vhostMapping) {
			channel = session.vhostMapping.channelName
		}
		
		log.info 'Content channel: ' + channel
		
		
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
		
		def showSetLocationTip = false;
		def unreadCount
		if (springSecurityService.currentUser) {
			
			def query = """
				select count(m) from Message m
				where (m.messageBoard.userA.id = :userId or m.messageBoard.userB.id = :userId)
				and m.isRead = :isRead and m.user.id <> :userId
			"""
			
			def count = Message.executeQuery(query, [userId: springSecurityService.currentUser.id, isRead: false])
			unreadCount = count.get(0)
			
			if (!springSecurityService.currentUser.location) {
				if (session['skipSetLocation']) {
					showSetLocationTip = true;
				} else {
					redirect (controller: 'map', action: 'welcome')
					return
				}
			}
		}
		
		def model = [
			params: params, 
			channel: myChannel, 
			unreadMsgCount: unreadCount, 
			showSetLocationTip: showSetLocationTip
		]
		
		if (myChannel.name == 'trade') {
//			redirect uri: '/maphome', absolute: false
//			forward controller: 'maphome', action: "trade"
			render view: "mapHome", model: model
		} else {
			render view: "richIndex", model: model
		}
		
	}
	
	def list() {
		
		def channel
		if (session.vhostMapping) {
			channel = session.vhostMapping.channelName
		}
		
		def myChannel
		if (channel) {
			myChannel = Channel.findByName(channel)
			if (!myChannel) {
				return response.sendError(404)
			}
		} else {
			myChannel = Channel.findByIsDefault(true)
		}
		
		session['channel'] = myChannel
		params.channel = myChannel.name
		
		def model = [
			params: params,
			channel: myChannel
		]
		
		render view: "index", model: model
	}
	
	def mapHome(String channel) {
		
		if (session.vhostMapping) {
			channel = session.vhostMapping.channelName
		}
		
		log.info 'Content channel: ' + channel
		
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
		
		def showSetLocationTip = false;
		def unreadCount
		if (springSecurityService.currentUser) {
			
			def query = """
				select count(m) from Message m
				where (m.messageBoard.userA.id = :userId or m.messageBoard.userB.id = :userId)
				and m.isRead = :isRead and m.user.id <> :userId
			"""
			
			def count = Message.executeQuery(query, [userId: springSecurityService.currentUser.id, isRead: false])
			unreadCount = count.get(0)
			
			if (!springSecurityService.currentUser.location) {
				if (session['skipSetLocation']) {
					showSetLocationTip = true;
				} else {
					redirect (controller: 'map', action: 'welcome')
				}
			}
		}
		
		[
			params: params,
			channel: myChannel,
			unreadMsgCount: unreadCount,
			showSetLocationTip: showSetLocationTip
		]
	}
}
