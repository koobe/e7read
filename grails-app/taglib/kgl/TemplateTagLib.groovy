package kgl

import grails.plugin.geocode.Point

class TemplateTagLib {

    def geocodingService

    static namespace = "template"
    //static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    def socialToolbar = { attrs, body ->
        out << render(
                template: '/taglib/template/socialToolbar',
                model: [
                        content: attrs.content,
                        address: geocodingService.getAddress(new Point(latitude: attrs.content?.location?.lat, longitude: attrs.content?.location?.lon))
                ]
        )
    }
}
