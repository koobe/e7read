package kgl

import org.jsoup.Jsoup
import groovy.json.JsonSlurper
import groovy.json.JsonOutput

import javax.script.ScriptEngine
import javax.script.ScriptEngineManager

class MapStyleController {

    def mapStyleService

    def snazzy(int id, String name) {

        def style = mapStyleService.loadFromSnazzyMaps(id, name)

        render contentType: 'text/plain',
                text: style.content
    }

    
}
