import groovy.json.JsonSlurper
import kgl.*

class CategoryBootStrap {

    def init = { servletContext ->

        log.info "Create default content category."

		def categoryJson = """
		{
			"category": [
				{
					"name" : "news",
					"child" : [
						{ "name" : "world", "child" : [
							{ "name" : "asia", "child" : [] },
							{ "name" : "us", "child" : [] }
						]},
						{ "name" : "political", "child" : [] },
						{ "name" : "life", "child" : [] },
						{ "name" : "business", "child" : [] }
					]
				},
				{
					"name" : "tech",
					"child" : []
				},
				{
					"name" : "travel",
					"child" : []
				}
			]
		}
		"""
		
		def enrollCategories = { parent, childList ->
			if (childList.size() != 0 ) {
				childList.each { node ->
					//save data
					log.info 'Create category, parent: ' + parent + "; category-name: " + node.name
					Category category = new Category(name: node.name);
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
