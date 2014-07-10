class BootStrap {

    def s3Service

    def init = { servletContext ->

        log.info("Check default S3 bucket.")

        // Create default s3 bucket
        if (!s3Service.doesBucketExist()) {
            s3Service.createBucket()
        }

    }

    def destroy = {
    }
}
