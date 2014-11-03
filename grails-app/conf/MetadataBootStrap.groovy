import groovy.json.JsonSlurper
import kgl.*

/**
 * 
 * @author Cloude
 *
 */
class MetadataBootStrap {
	
	def grailsApplication

    def init = { servletContext ->
		
		bootstrapChannelData()
		bootstrapCategoryData()
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
							canAnonymous: node.canAnonymous);
					} else {
						
						if (node.isDefault) {
							channel.isDefault = node.isDefault
						}
						if (node.logoImg) {
							channel.logoImg = node.logoImg
						}
						if (node.canAnonymous) {
							channel.canAnonymous = node.canAnonymous
						}
					}
					
					channel.save flush: true
				}
			}
		}
		
		def jsonFile = grailsApplication.getParentContext().getResource("classpath:json/channel.json").file
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
					
					category.save flush: true
					owner.call(node.name, node.child)
				}
			}
		}
		
		def jsonFile = grailsApplication.getParentContext().getResource("classpath:json/category.json").file
		def jsonStr = jsonFile.text
		log.info jsonStr
				
		def json = new JsonSlurper().parseText(jsonStr)
		def category = json.category
		enrollCategories(null, category)
	}
}
