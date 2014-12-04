package kgl

import grails.transaction.Transactional
import org.jsoup.Jsoup
import java.util.zip.GZIPInputStream

@Transactional
class MapStyleService {

    private static final String USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20100101 Firefox/5.0'

    private static final String SNAZZY_FEED = 'https://snazzymaps.com/feed'

    /**
     * Load map styles from https://snazzymaps.com/
     */
    MapStyle loadFromSnazzyMaps(int id, String name) {

        def style = MapStyle.findByName(name)

        if (!style) {
            String b64image = new URL("https://az594329.vo.msecnd.net/assets/${id}-${name}.png").getBytes().encodeBase64().toString()

            String url = "https://snazzymaps.com/style/${id}/${name}"

            log.info "Parse SnazzyMaps URL: ${url}"

            String jsonObject = Jsoup.connect(url).userAgent(USER_AGENT).referrer('https://snazzymaps.com/').get().select('#style-json').text()

            log.info "plain => ${jsonObject}"

            style = new MapStyle(name: name, content: jsonObject, previewImageType: 'image/png', previewImageContent: b64image)

            style.save flush: true
        }

        return style
    }

    List<MapStyle> loadAllFromSnazzyMapsFeed(int limit) {

        List<MapStyle> list = new ArrayList<MapStyle>()

        def rss = new XmlSlurper().parseText(readTextFromURL(new URL(SNAZZY_FEED)))

        rss.channel.item.each {

            String link = it.link.text()

            if (list.size() < limit && link.startsWith('https://snazzymaps.com/style/')) {

                log.info "Process ${link}"

                link = link.replace('https://snazzymaps.com/style/', '')

                def token = link.split('/')

                if (token?.size() == 2) {
                    int id = Integer.parseInt(token[0])
                    String name = token[1]

                    list << loadFromSnazzyMaps(id, name)
                }
            }
        }

        return list
    }

    private String readTextFromURL(URL url) {
        def text
        try {
            text = new GZIPInputStream(url.newInputStream(requestProperties:['Accept-Encoding': 'gzip,deflate'])).text
        }
        catch (ZipException) {
            text = url.getText('UTF-8')
        }
        return text
    }
}
