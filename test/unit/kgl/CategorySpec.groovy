package kgl

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Category)
class CategorySpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test create domain"() {

        def category = new Category(name: "Nature")

        assertNotNull category.save()

        def category2 = Category.findByName("Nature")

        category2.name = "Natural"
        category2.save()

        category2.delete()
    }
}
