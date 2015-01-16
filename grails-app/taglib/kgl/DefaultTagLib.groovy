package kgl

class DefaultTagLib {
    //static namespace = "default"

    static defaultEncodeAs = [taglib:'none']
    static encodeAsForTags = [alert: [taglib:'none']]

    def config = { attrs, body ->
        out << Configuration.findByName(attrs.name)?.content
    }
}
