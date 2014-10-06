import groovy.json.JsonSlurper
import kgl.*

/**
 * 
 * @author Cloude
 *
 */
class MetadataBootStrap {

    def init = { servletContext ->
		
		bootstrapChannelData()
		bootstrapCategoryData()
        
    }
	
    def destroy = {
    }
	
	protected void bootstrapChannelData() {
		
		log.info "Create default channel data."
		
		def channelJson = """
		{
			"channel": [
				{
					"name" : "e7read",
					"isDefault" : true,
					"logoImg": "/assets/e7logo.png",
					"canAnonymous": true
				},
				{
					"name" : "trade",
					"isDefault" : false,
					"canAnonymous": false
				}
			]
		}
		"""
				
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
				
		def json = new JsonSlurper().parseText(channelJson)
		def channelList = json.channel
		enrollChannel(channelList)
	}
	
	protected void bootstrapCategoryData() {
		
		log.info "Create default content category."
		
		def categoryJson = """
		{
			"category": [
				{
					"name" : "life",
					"child" : [],
					"rankOnTop" : 1,
					"enable": true,
					"order": 1,
					"channel": "e7read"
				},
				{
					"name" : "tech",
					"child" : [],
					"rankOnTop" : 2,
					"enable": true,
					"order": 2,
					"channel": "e7read"
				},
				{
					"name" : "entertainment",
					"child" : [],
					"rankOnTop" : 3,
					"enable": true,
					"order": 3,
					"channel": "e7read"
				},
				{
					"name" : "opinion",
					"child" : [],
					"enable": true,
					"order": 4,
					"channel": "e7read"
				},
				{
					"name" : "industry",
					"child" : [],
					"enable": true,
					"order": 5,
					"channel": "e7read"
				},
				{
					"name" : "report",
					"child" : [],
					"enable": true,
					"order": 6,
					"channel": "e7read"
				},
				{
					"name" : "share",
					"child" : [],
					"enable": true,
					"order": 7,
					"channel": "e7read"
				},
				{
					"name" : "free",
					"child" : [],
					"rankOnTop" : 1,
					"enable": true,
					"order": 1,
					"channel": "trade"
				},
				{
					"name" : "3c",
					"child" : [],
					"enable": true,
					"order": 3,
					"channel": "trade"
				},
				{
					"name" : "game",
					"child" : [],
					"rankOnTop" : 2,
					"enable": true,
					"order": 2,
					"channel": "trade"
				},
				{
					"name" : "home",
					"child" : [],
					"rankOnTop" : 3,
					"enable": true,
					"order": 4,
					"channel": "trade"
				}
			]
		}
		"""
				
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
				
		def json = new JsonSlurper().parseText(categoryJson)
		def category = json.category
		enrollCategories(null, category)
	}
}
