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
		
		log.info(params);

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
		
		def searchResult = searchService.searchContent(channelName, categoryName, queryString, geoPoint, distance, params);
		
		//def contents = searchResult.searchResults.collect { Content.get(it.id) }
		
		render searchResult.searchResults.collect {

            def iconUrl = it.iconUrl

            if (!iconUrl) {
                iconUrl = it.categories?.getAt(0)?.iconUrl
            }

            if (!iconUrl) {
                iconUrl = it.channel?.iconUrl
            }

            println it.channel

            [
                cropTitle  : it.cropTitle,
                cropText   : it.cropText,
                location   : [lat: it.location?.lat, lon: it.location?.lon],
                shareUrl   : createLink(controller: 'content', action: 'share', id: it.id, absolute: true),
                coverUrl   : it.coverUrl,
                iconUrl    : iconUrl,
                channel    : it.channel?.name,
                categories : it.categories?.collect { it.name }
            ]

        } as JSON
    }
	
	def contents() {
		
		log.info(params);
		
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
		
		def searchResult = searchService.searchContent(channelName, categoryName, queryString, geoPoint, distance, params);
		
//		searchResult.searchResults.each { result ->
////			def content = Content.get(result.id)
////			if (content && !content.isDelete && !content.isPrivate && content.channel.name.equals(channelName)) {
////				contentList << content
////			}
//			log.info result.id
//			log.info "user name: ${result.user.fullName}"
//			
//			log.info result.user as JSON
//			
//			log.info result.location.city
//			result.categories.each {
//				log.info it.name
//			}
//		}

		JSON.use("deep")
		render searchResult.searchResults as JSON
	}
}
