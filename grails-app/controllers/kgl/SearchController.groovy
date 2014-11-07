package kgl

import grails.converters.JSON

import org.grails.plugins.elasticsearch.ElasticSearchService

class SearchController {

    static defaultAction = 'index'

    SearchService searchService

    def index() {
        def result = Content.search(params.q)

        render result as JSON
    }

    /**
     * /search/content?channel=...&c=...&q=...&geo=LAT,LNG&distance=...
     * @return
     */
    def content() {

        String channelName = params.channel?:grailsApplication.config.grails.application.default_channel
        String categoryName = params.c
        def queryString = params.q
        GeoPoint geoPoint = null
        def distance = params.distance

        if (params.geo) {
            def latlon = params.geo.split(',')
            double lat = latlon[0] as double
            double lon = latlon[1] as double
            geoPoint = new GeoPoint(lat: lat, lon: lon)
        }

        render searchService.searchContent(channelName, categoryName, queryString, geoPoint, distance, params).collect {
            [
                    cropTitle  : it.cropTitle,
                    cropText   : it.cropText,
                    location   : [lat: it.location?.lat, lon: it.location?.lon],
                    shareUrl   : createLink(controller: 'content', action: 'share', id: it.id, absolute: true),
                    coverUrl   : it.coverUrl,
                    channel    : it.channel?.name,
                    categories : it.categories?.collect { it.name }
            ]
        } as JSON
    }

}
