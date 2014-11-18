package kgl

import grails.transaction.Transactional

@Transactional
class CategoryService {

    private static final String ___CATEGORIES_QUERY = """
        select category
        from Category as category
        where category.category is null
            and enable = true
            and channel.name = :channelName
        order by order asc
    """

    def list(String channelName) {
        Category.executeQuery(___CATEGORIES_QUERY, [channelName: channelName])
    }
}
