package kgl

import org.springframework.web.multipart.commons.CommonsMultipartFile

import java.util.logging.Logger;

import com.amazonaws.auth.BasicAWSCredentials
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client
import com.amazonaws.services.s3.model.CannedAccessControlList
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import com.amazonaws.services.s3.model.ObjectMetadata
import com.amazonaws.services.s3.model.PutObjectRequest

import grails.transaction.Transactional
import grails.util.Environment

import javax.annotation.PostConstruct

@Transactional
class S3Service {

    def grailsApplication

    String accessKey
    String secretKey
    String bucket
    BasicAWSCredentials credentials
	AmazonS3 s3client;

    @PostConstruct
    void initialize() {
        accessKey = grailsApplication.config.aws.credentials.accessKey
        secretKey = grailsApplication.config.aws.credentials.secretKey
        bucket = grailsApplication.config.aws.s3.bucket
        credentials = new BasicAWSCredentials(accessKey, secretKey)
		s3client = new AmazonS3Client(credentials);
    }

    boolean doesBucketExist() {
        doesBucketExist(bucket)
    }

    boolean doesBucketExist(bucket) {
        s3client.doesBucketExist(bucket)
    }

    void createBucket() {
        createBucket(bucket)
    }

    void createBucket(bucket) {
        log.info "Create S3 bucket: ${bucket}"
        s3client.createBucket(bucket)
    }

    @Transactional
    S3File upload(owner, CommonsMultipartFile file, InputStream inputStream, boolean isPublic, String remark) {

        def s3file = new S3File()

        s3file.owner = owner
        s3file.file = file
        s3file.isPublic = isPublic
        s3file.remark = remark

        log.info "Upload S3File ${s3file.originalFilename} (Content-Type: ${s3file.contentType}, Content-Length: ${s3file.contentLength} bytes)"

        if (!s3file.bucket) {
            s3file.bucket = bucket
        }

        log.info "Save to bucket: ${s3file.bucket}"

        if (!s3file.objectKey) {
            s3file.objectKey = "${Environment.current.name}/${s3file.ownerId}/${UUID.randomUUID()}/${s3file.originalFilename}"
            log.info "Auto-create s3 object objectKey: ${s3file.objectKey}"
        }

        def metadata = new ObjectMetadata()
        metadata.contentLength = s3file.contentLength
        metadata.contentType = s3file.contentType

        def request = new PutObjectRequest(s3file.bucket, s3file.objectKey, inputStream, metadata)

        if (s3file.isPublic) {
            request.setCannedAcl(CannedAccessControlList.PublicRead)
        }

		// put object to s3
        def result = s3client.putObject(request)
		
        s3file.url = s3client.getUrl(s3file.bucket, s3file.objectKey).toString().replaceFirst("https://", "http://")
        s3file.resourceUrl = s3file.url
        s3file.hasBeenUploaded = true

        s3file.save flush: true

        return s3file
    }
}
