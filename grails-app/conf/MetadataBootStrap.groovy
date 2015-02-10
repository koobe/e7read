import groovy.json.JsonSlurper
import kgl.Category
import kgl.Channel
import kgl.VirtualHost

/**
 * 
 * @author Cloude
 *
 */
class MetadataBootStrap {
	
	def grailsApplication

    def grailsLinkGenerator

    def init = { servletContext ->
		if (grailsApplication.config.grails.application.bootstrap_meta) {
			bootstrapChannelData()
			bootstrapCategoryData()
		}
    }
	
    def destroy = {
    }
	
	protected void bootstrapChannelData() {
		
		log.info "Create default channel data."
				
		def enrollChannel = { channelList ->
			if (channelList.size() != 0 ) {
				channelList.each { node ->
					//save data
					log.info 'Create channel, channel name: ' + node.name
					
					def channel = Channel.findByName(node.name)
					
					if (!channel) {
						channel = new Channel(
							name: node.name,
							isDefault: node.isDefault,
							logoImg: node.logoImg,
							smallLogoUrl: node.smallLogoUrl,
							canAnonymous: node.canAnonymous,
							themeType: node.themeType,
							showInPanel: node.showInPanel,
							iconUrl: node.iconUrl,
							order: node.order)
					} else {
						channel.isDefault = node.isDefault
						channel.logoImg = node.logoImg
						channel.canAnonymous = node.canAnonymous
						channel.themeType = node.themeType
						channel.smallLogoUrl = node.smallLogoUrl
						channel.showInPanel = node.showInPanel
						channel.order = node.order
						channel.iconUrl = node.iconUrl
					}

//                    if (node.iconUrl) {
//                        if (node.iconUrl.startsWith('http://') || node.iconUrl.startsWith('https://')) {
//                            channel.iconUrl = node.iconUrl
//                        }
//                        else {
//                            channel.iconUrl = grailsLinkGenerator.asset(src: "marker-32/${node.iconUrl}", absolute: true)
//                        }
//                    }
//                    else {
//                        // use default icon
//                        channel.iconUrl = grailsLinkGenerator.asset(src: 'e7logo-marker-icon1-32x32.png', absolute: true)
//                    }
//
//                    log.info "channel.iconUrl = ${channel.iconUrl}"
					
					channel.save flush: true

					if (node.vhost) {
						node.vhost.split(';').each {
							host ->

								log.info "(VirtualHost) create vhost ${host} -> channel[${channel.name}]"

								def vhost = VirtualHost.findOrCreateByHostname(host)
								vhost.channel = channel
								vhost.webpageTitle = node.webpageTitle
								vhost.save flush: true
						}
					}
				}
			}
		}
		
		def jsonFile = grailsApplication.parentContext.getResource("classpath:json/channel.json").file
		def jsonStr = jsonFile.text
		log.info jsonStr	
		
		def json = new JsonSlurper().parseText(jsonStr)
		def channelList = json.channel
		enrollChannel(channelList)
	}
	
	protected void bootstrapCategoryData() {
		
		log.info "Create default content category."
				
		def enrollCategories = { parent, childList ->
			if (childList.size() != 0 ) {
				childList.each { node ->
					//save data
					log.info 'Create category, parent: ' + parent + "; category-name: " + node.name
					
					def category = Category.findByName(node.name)
					
					if (!category) {
						category = new Category(name: node.name);
					}
					
					if (node.rankOnTop) {
						category.rankOnTop = node.rankOnTop
					}
					if (node.enable) {
						category.enable = node.enable
					}
					if (node.order) {
						category.order = node.order
					}
					if (parent) {
						def parentCategory = Category.findByName(parent)
						category.category = parentCategory;
					}
					if (node.channel) {
						def channel = Channel.findByName(node.channel)
						category.channel = channel
					}
					
					category.iconUrl = node.iconUrl

//                    if (node.iconUrl) {
//                        if (node.iconUrl.startsWith('http://') || node.iconUrl.startsWith('https://')) {
//                            category.iconUrl = node.iconUrl
//                        }
//                        else {
//                            category.iconUrl = grailsLinkGenerator.asset(src: "marker-32/${node.iconUrl}", absolute: true)
//                        }
//                    }
//                    else {
//                        // use default icon
//                        category.iconUrl = grailsLinkGenerator.asset(src: 'e7logo-marker-icon1-32x32.png', absolute: true)
//                    }
//
//                    log.info "Icon URL: ${category.iconUrl}"
					
					category.save flush: true
					owner.call(node.name, node.child)
				}
			}
		}
		
		def jsonFile = grailsApplication.parentContext.getResource("classpath:json/category.json").file
		def jsonStr = jsonFile.text
		log.info jsonStr
				
		def json = new JsonSlurper().parseText(jsonStr)
		def category = json.category
		enrollCategories(null, category)
	}
}
