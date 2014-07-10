package kgl

class BootstrapTagLib {
    static namespace = "bs3"

    static defaultEncodeAs = [taglib:'none']
    static encodeAsForTags = [alert: [taglib:'none']]

    def alert = { attrs, body ->
        out << """<div class="alert alert-${attrs.type?:'success'}">"""
        out << body()
        out << '</div>'
    }

    def list = { attrs, body ->


        out << attrs.data

        if (attrs.data) {
            attrs.data.each {
                out << "<p>${it}</p>"
            }
        }

    }
}
