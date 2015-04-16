import groovy.json.JsonSlurper
import kgl.Configuration
import kgl.Localization
import org.springframework.context.MessageSource

class BootStrap {

    def s3Service

    def grailsApplication

    def mapStyleService

    def customMailService

    def init = { servletContext ->

        // Create default s3 bucket

        log.info 'Create default S3 bucket if not exists'

        if (!s3Service.doesBucketExist()) {
            s3Service.createBucket()
        }


        log.info 'Load some map styles from SnazzyMaps'

		// prevent from the failed startup
		try {
			mapStyleService.loadAllFromSnazzyMapsFeed(5)
			mapStyleService.loadFromSnazzyMaps(80, 'cool-grey') //default
		} catch (Exception e) {
			e.printStackTrace()
		}

        // process for different environments

        environments {
            development {

                // Cleanup Elasticsearch caches

                //log.info 'Remove Elasticsearch indexes'

                //elasticSearchAdminService.deleteIndex()

                log.info 'Remove Elasticsearch cache directories'

                File rootPath = grailsApplication.parentContext.getResource("classpath:.").file

                File dataPath = new File(rootPath, 'data/elasticsearch')

                if (dataPath.exists() && dataPath.isDirectory()) {
                    log.info "Delete data directory ${dataPath}"

                    boolean result = dataPath.deleteDir()

                    log.info "Delete result: ${result}"
                }
            }
        }



        log.info "Fetch runtime configuration and save to Configuration database"

        def jsonText = grailsApplication.parentContext.getResource("classpath:json/configuration.json").file.text
        def json = new JsonSlurper().parseText(jsonText)

        json.keySet().each {  key ->
            def value = json.get(key)

            log.info "Check configuration: ${key} = ${value}"

            def config = Configuration.findByName(key)

            if (!config) {
                config = new Configuration(name: key, content: value)
                config.save flush: true
            }
        }



        log.info "Send E-Mail notifications."

        environments {
            development {

                customMailService.serverStartupNotification('kyle@koobe.com.tw')
            }
        }


    }

    def destroy = {
    }
}
