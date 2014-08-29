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
					"name" : "news",
					"child" : [
						{ "name" : "world", "child" : [
							{ "name" : "asia", "child" : [
								{ "name" : "china", "child" : [] },
								{ "name" : "japan", "child" : [] },
								{ "name" : "taiwan", "child" : [] }
							] },
							{ "name" : "us", "child" : [] }
						]},
						{ "name" : "political", "child" : [] },
						{ "name" : "life", "child" : [] },
						{ "name" : "business", "child" : [], "rankOnTop" : 4 }
					]
				},
				{
					"name" : "tech",
					"child" : [],
					"rankOnTop" : 3
				},
				{
					"name" : "travel",
					"child" : [],
					"rankOnTop" : 1
				},
				{
					"name" : "sport",
					"child" : []
				},
				{
					"name" : "future",
					"child" : [
						{ "name" : "science", "child" : [] },
						{ "name" : "tech-", "child" : [] },
						{ "name" : "health", "child" : [] }
					],
					"rankOnTop" : 2
				},
				{
					"name" : "radio",
					"child" : []
				},
				{
					"name" : "learning",
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
					
					def category = Category.findByName(node.name)
					if (!category) {
						category = new Category(name: node.name);
					}
					
					if (node.rankOnTop) {
						category.rankOnTop = node.rankOnTop
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
