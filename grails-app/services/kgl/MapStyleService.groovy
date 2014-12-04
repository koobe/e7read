package kgl

import grails.transaction.Transactional
import org.jsoup.Jsoup

import javax.script.ScriptEngineManager

@Transactional
class MapStyleService {

    private static final String USER_AGENT = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20100101 Firefox/5.0"

    def engine = new ScriptEngineManager().getEngineByName("JavaScript")

    /**
     * Load map styles from https://snazzymaps.com/
     */
    MapStyle loadFromSnazzyMaps(int id, String name) {

        String url = "https://snazzymaps.com/style/${id}/${name}"

        def doc = Jsoup.connect(url).userAgent(USER_AGENT).referrer('https://snazzymaps.com/').get()

        String jsonObject = doc.select('pre#style-json').text()

        def engine = new ScriptEngineManager().getEngineByName("JavaScript")

        engine.eval("output=JSON.stringify(${jsonObject});")

        String plainJson = engine.get('output')

        log.info plainJson

        return new MapStyle(name: name, content: plainJson)
    }
}
