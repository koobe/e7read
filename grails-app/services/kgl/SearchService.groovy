package kgl

import grails.transaction.Transactional

import org.elasticsearch.action.search.SearchRequest
import org.elasticsearch.action.search.SearchType
import org.elasticsearch.common.geo.GeoDistance
import org.elasticsearch.common.unit.DistanceUnit
import org.elasticsearch.index.query.FilterBuilder;
import org.elasticsearch.index.query.FilterBuilders
import org.elasticsearch.index.query.QueryBuilders
import org.elasticsearch.search.builder.SearchSourceBuilder
import org.elasticsearch.search.sort.SortBuilders
import org.elasticsearch.search.sort.SortOrder
import org.grails.plugins.elasticsearch.ElasticSearchService

@Transactional
class SearchService {
	
	ElasticSearchService elasticSearchService
	
	/**
	 * Search content by given parameters
	 * @param channelName
	 * @param categoryName
	 * @param queryString
	 * @param geoPoint
	 * @return
	 */
    def searchContent(params) {
		
		def channelName = params.channel
		def categoryName = params.c
		def queryString = params.q
		def geoPoint = params.geo
		def distance = params.distance
		
		def lat
		def lon
		
		def sortByPostDate = SortBuilders.fieldSort("datePosted").order(SortOrder.DESC)
		def sortByNear
		
		if (geoPoint) {
			def latlon = params.geo.split(',')
			lat = latlon[0] as double
			lon = latlon[1] as double
			log.info "${lat} , ${lon}"
			
			sortByNear = SortBuilders.
				geoDistanceSort("location").
				point(lat, lon).
				unit(DistanceUnit.KILOMETERS).
				order(SortOrder.ASC)
		}
		
		// must have channel name
		def query = QueryBuilders.boolQuery()
			.must(QueryBuilders.hasParentQuery("channel", QueryBuilders.matchQuery("name", channelName)))
			
		if (queryString) {
			query = query.must(QueryBuilders.queryString(queryString))
		}
		
		def filter
		
		if (categoryName || geoPoint) {
			
			def filterList = []
			
			def categoryFilter
			// when give category name than add filter
			if (categoryName) {
				categoryFilter = FilterBuilders.nestedFilter("categories",
					QueryBuilders.boolQuery()
						.must(QueryBuilders.matchQuery("categories.name", categoryName)))
				
				filterList << categoryFilter
			}
			

			def geoDistanceFilter
			if (geoPoint) {
				geoDistanceFilter = FilterBuilders.geoDistanceFilter("location")
				    .point(lat, lon)
				    .distance(distance? distance as double: 100, DistanceUnit.KILOMETERS)
				    .optimizeBbox("memory")
				    .geoDistance(GeoDistance.ARC);
						
				filterList << geoDistanceFilter
			}
			
			filter = FilterBuilders.andFilter(filterList.toArray(new FilterBuilder[0]))
			
//			log.info filter
		}
		
		SearchSourceBuilder source = new SearchSourceBuilder()
		source.from(params.offset? params.offset as int: 0)
		source.size(params.size? params.size as int: 100)
		
		if (sortByNear) {
			source.sort(sortByNear)
		}
		source.sort(sortByPostDate)
		
		source.query(query)
		
		if (filter) {
			source.postFilter(filter)
		}
		
		SearchRequest request = new SearchRequest()
		request.searchType SearchType.DFS_QUERY_THEN_FETCH
		request.source(source)
		
		def result = elasticSearchService.search(request, [
			indices: Content,
			types: Content
		])
		
		return result
	}
}
