package kgl

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class DebugController {

    def s3Service

    def index() {
        [
                actions: [
                        'aws',
                        's3file'
                ]
        ]
    }

    def aws() {

        def result = [
                s3_default_bucket_exists: s3Service.doesBucketExist()
        ]

        render result as JSON
    }

    def s3file() {
        render S3File.list() as JSON
    }

    def rds() {

        def result = [
                dbName: System.getProperty("RDS_DB_NAME"),
                userName: System.getProperty("RDS_USERNAME"),
                password: System.getProperty("RDS_PASSWORD"),
                hostname: System.getProperty("RDS_HOSTNAME"),
                port: System.getProperty("RDS_PORT")
        ]

        render result as JSON
    }
}
