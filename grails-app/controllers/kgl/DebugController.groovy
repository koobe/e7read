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
                RDS_DB_NAME: System.getProperty("RDS_DB_NAME"),
                RDS_USERNAME: System.getProperty("RDS_USERNAME"),
                RDS_PASSWORD: System.getProperty("RDS_PASSWORD"),
                RDS_HOSTNAME: System.getProperty("RDS_HOSTNAME"),
                RDS_PORT: System.getProperty("RDS_PORT"),
                JDBC_CONNECTION_STRING: System.getProperty("JDBC_CONNECTION_STRING")
        ]

        render result as JSON
    }

    def email() {
        sendMail {
            to "lyhcode@gmail.com"
            subject "Hello Fred"
            body 'How are you?'
        }

        def result = [
                result: true
        ]

        render result as JSON
    }
}
