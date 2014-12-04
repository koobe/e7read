package kgl

import grails.converters.JSON

import javax.script.ScriptEngineManager

/**
 * e.g. /mapStyleFromSnazzy/15/subtle-grayscale
 */
class MapStyleController {

    def mapStyleService

    /**
     * Load from snazzy
     *
     * @param id
     * @param name
     * @return
     */
    def snazzy(int id, String name) {

        def style = mapStyleService.loadFromSnazzyMaps(id, name)

        log.info "Fetched ${style}"

        render style as JSON
    }

    /**
     * Load all from snazzy feed
     */
    def snazzyFeed() {

        int limit = params.getInt('limit', 3)

        def List<MapStyle> list = mapStyleService.loadAllFromSnazzyMapsFeed(limit)

        render "${list.size()}"
    }

    def json() {

        render contentType: 'application/json',
                text: stringify(MapStyle.findByName(params.id).content)
    }

    def debugRaw() {
        render contentType: 'text/plain', text: MapStyle.findByName(params.id).content
    }

    def image() {

        def style = MapStyle.findByName(params.id)

        render contentType: style.previewImageType, file: style.previewImageContent.decodeBase64()
    }

    def debug() {
        render MapStyle.list() as JSON
    }

    private String stringify(jsonObject) {
        def engine = new ScriptEngineManager().getEngineByName("JavaScript")

        engine.eval("output=JSON.stringify(${jsonObject});")

        engine.get('output')
    }
}
