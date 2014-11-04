class BootStrap {

    def s3Service

    def elasticSearchAdminService

    def init = { servletContext ->

        log.info 'Create default S3 bucket if not exists'

        // Create default s3 bucket
        if (!s3Service.doesBucketExist()) {
            s3Service.createBucket()
        }

        log.info 'Remove Elasticsearch indexes'

        //elasticSearchAdminService.deleteIndex()

    }

    def destroy = {
    }
}
