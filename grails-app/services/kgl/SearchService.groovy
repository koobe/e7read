package kgl

import grails.converters.JSON
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

@Transactional
class SearchService {

    private final static double __DEFAULT_DISTANCE = 100;

    def elasticSearchService

    def grailsApplication

    /**
     * Search content by given parameters
     * @param channelName
     * @param categoryName
     * @param queryString
     * @param geoPoint
     * @param distance
     * @param params include offset, size
     * @return
     */
    def searchContent(String channelName, String categoryName, String queryString, GeoPoint geoPoint, Double distance, params) {

        // default sort by datePosted
        def sortByPostDate = SortBuilders.fieldSort("datePosted").order(SortOrder.DESC)

        // setup geo search sorter
        def sortByNear = null
        if (geoPoint) {
            log.info "Sort by GeoPoint(lat: ${geoPoint.lat} , lon: ${geoPoint.lon})"

            sortByNear = SortBuilders.
                    geoDistanceSort("location").
                    point(geoPoint.lat, geoPoint.lon).
                    unit(DistanceUnit.KILOMETERS).
                    order(SortOrder.ASC)
        }

        // must have channel name
        def query = QueryBuilders
                .boolQuery()
                .must(QueryBuilders
                .hasParentQuery("channel", QueryBuilders.matchQuery("name", channelName)))

        // has a query string
        if (queryString) {
            query = query.must(QueryBuilders.queryString(queryString))
        }

        def filters = []

        // when give category name than add filter
        if (categoryName && categoryName != '*') {
            def categoryQuery = QueryBuilders
                    .boolQuery()
                    .must(QueryBuilders.matchQuery("categories.name", categoryName))

            filters << FilterBuilders.nestedFilter("categories", categoryQuery)
        }

        // when give geoPoint than add distance filter
        if (geoPoint) {
            filters << FilterBuilders.geoDistanceFilter("location")
                    .point(geoPoint.lat, geoPoint.lon)
                    .distance(distance?:__DEFAULT_DISTANCE, DistanceUnit.KILOMETERS)
                    .optimizeBbox("memory")
                    .geoDistance(GeoDistance.ARC)
        }

        SearchSourceBuilder source = new SearchSourceBuilder()

        source.from(params.offset ? params.offset as int : 0)
        source.size(params.size ? params.size as int : 100)

        source.query(query)

        if (sortByNear) {
            source.sort(sortByNear)
        }

        source.sort(sortByPostDate)

        // setup post filters
        if (filters) {
            source.postFilter(FilterBuilders.andFilter(filters.toArray(new FilterBuilder[0])))
        }

        SearchRequest request = new SearchRequest()
        request.searchType SearchType.DFS_QUERY_THEN_FETCH
        request.source(source)

        def results = elasticSearchService.search(request, [
                indices: Content,
                types  : Content
        ])

        // get missing fields in search result
        results //.searchResults.collect { Content.get(it.id) }
    }
}
