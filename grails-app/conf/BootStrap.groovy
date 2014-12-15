import org.springframework.context.MessageSource

class BootStrap {

    def s3Service

    def grailsApplication

    def mapStyleService

    def init = { servletContext ->

        // Create default s3 bucket

        log.info 'Create default S3 bucket if not exists'

        if (!s3Service.doesBucketExist()) {
            s3Service.createBucket()
        }


        log.info 'Load some map styles from SnazzyMaps'

        mapStyleService.loadAllFromSnazzyMapsFeed(5)
        mapStyleService.loadFromSnazzyMaps(80, 'cool-grey') //default


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
    }

    def destroy = {
    }
}
