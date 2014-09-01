import groovy.json.JsonSlurper
import kgl.*

/**
 * 
 * @author Cloude
 *
 */
class CategoryBootStrap {

    def init = { servletContext ->

        log.info "Create default content category."

		def categoryJson = """
		{
			"category": [
				{
					"name" : "life",
					"child" : [],
					"rankOnTop" : 1,
					"enable": true,
					"order": 1
				},
				{
					"name" : "tech",
					"child" : [],
					"rankOnTop" : 2,
					"enable": true,
					"order": 2
				},
				{
					"name" : "entertainment",
					"child" : [],
					"rankOnTop" : 3,
					"enable": true,
					"order": 3
				},
				{
					"name" : "opinion",
					"child" : [],
					"enable": true,
					"order": 4
				},
				{
					"name" : "industry",
					"child" : [],
					"enable": true,
					"order": 5
				},
				{
					"name" : "report",
					"child" : [],
					"enable": true,
					"order": 6
				},
				{
					"name" : "share",
					"child" : [],
					"enable": true,
					"order": 7
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
					category.save flush: true
					owner.call(node.name, node.child)
				}
			}
		}
				
		def json = new JsonSlurper().parseText(categoryJson)
		def category = json.category
		enrollCategories(null, category)
    }
	
    def destroy = {
    }
}
