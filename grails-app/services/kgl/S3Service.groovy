package kgl

import com.amazonaws.auth.BasicAWSCredentials
import com.amazonaws.services.s3.AmazonS3Client
import com.amazonaws.services.s3.model.CannedAccessControlList
import com.amazonaws.services.s3.model.ObjectMetadata
import com.amazonaws.services.s3.model.PutObjectRequest
import com.amazonaws.services.s3.model.ListObjectsRequest
import grails.transaction.Transactional
import grails.util.Environment
import org.springframework.web.multipart.commons.CommonsMultipartFile

import javax.annotation.PostConstruct

@Transactional
class S3Service {

    def grailsApplication

    def imageService

    String accessKey
    String secretKey
    String bucket
    BasicAWSCredentials credentials
	AmazonS3Client s3client;

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

    def listBuckets() {
        s3client.listBuckets().collect { it.name }
    }

    def listObjects(String bucket, String prefix) {
        s3client.listObjects(bucket, prefix).objectSummaries.collect { it.key }
    }

    def listObjects(String bucket, String prefix, String delimiter) {
        def request = new ListObjectsRequest()
                .withBucketName(bucket)
                .withPrefix(prefix)
                .withDelimiter(delimiter)
        s3client.listObjects(request).commonPrefixes.collect { it }
    }

    def getObject(String bucket, String key) {
        s3client.getObject(bucket, key)?.objectContent
    }

    String getObjectText(String bucket, String key) {
        s3client.getObject(bucket, key)?.objectContent?.text
    }

    URL generatePresignedUrl(String bucket, String key) {
        s3client.generatePresignedUrl(bucket, key, new Date()+15)
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

        def keyPrefix = "${Environment.current.name}/${s3file.ownerId}/${UUID.randomUUID()}"

        if (!s3file.objectKey) {
            s3file.objectKey = "${keyPrefix}/${s3file.originalFilename}"
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

        // make thumbnail
        if (isImageFile(s3file.originalFilename)) {

            //File fromFile = File.createTempFile("tmp", s3file.originalFilename)
            //fromFile << inputStream

            ByteArrayOutputStream os = new ByteArrayOutputStream()
            imageService.thumbnail(file.inputStream, os, KglConstant.THUMBNAIL_MAX_WIDTH, KglConstant.THUMBNAIL_MAX_HEIGHT)
            ByteArrayInputStream is = new ByteArrayInputStream(os.toByteArray())

            metadata = new ObjectMetadata()
            metadata.contentLength = os.size()
            metadata.contentType = s3file.contentType

            s3file.thumbnailObjectKey = "${keyPrefix}/thumbnail-${s3file.originalFilename}"

            if (!s3file.thumbnailObjectKey.toLowerCase().endsWith('.jpg') || !s3file.thumbnailObjectKey.toLowerCase().endsWith('.jpeg')) {
                s3file.thumbnailObjectKey = "${s3file.thumbnailObjectKey}.jpg"
            }

            request = new PutObjectRequest(s3file.bucket, "${s3file.thumbnailObjectKey}", is, metadata)

            if (s3file.isPublic) {
                request.setCannedAcl(CannedAccessControlList.PublicRead)
            }

            log.info "Upload thumbnail for image file and save to ${s3file.thumbnailObjectKey}"

            s3client.putObject(request)

            s3file.thumbnailUrl = s3client.getUrl(s3file.bucket, s3file.thumbnailObjectKey).toString().replaceFirst("https://", "http://")

            // make smaller thumbnail for dataUrl
            os = new ByteArrayOutputStream()
            imageService.thumbnail(file.inputStream, os, KglConstant.THUMBNAIL_TINY_MAX_WIDTH, KglConstant.THUMBNAIL_TINY_MAX_HEIGHT)
            s3file.dataUrl = "data:${s3file.contentType};base64,${os.toByteArray().encodeBase64().toString()}"

            log.info "Thumbnail URL: ${s3file.thumbnailUrl}"
        }

        s3file.save flush: true

        return s3file
    }

    boolean isImageFile(String filename) {
        filename = filename.toLowerCase()

        if (filename.endsWith(".jpg") || filename.endsWith(".jpeg")) {
            return true
        }

        if (filename.endsWith(".gif")) {
            return true
        }

        if (filename.endsWith(".png")) {
            return true
        }

        return false
    }
}
