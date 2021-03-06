package kgl

import org.springframework.web.multipart.commons.CommonsMultipartFile

class S3File {

    /**
     * Use UUID for S3File id
     */
    String id

    User owner       // Who uload the file will be the owner

    String originalFilename

    String contentType
    Long contentLength

    String bucket
    String objectKey

    String thumbnailUrl
    String thumbnailObjectKey

    /**
     * An URL for the object stored in the specified bucket and objectKey.
     */
    String url

    String dataUrl

    /**
     * The URL to the objectKey in the bucket given, using the client's scheme and endpoint.
     */
    String resourceUrl

    Boolean hasBeenUploaded

    Boolean isPublic

    Date dateCreated
    Date lastUpdated

    /**
     * Attach this object to specified domain class name
     */
    //String attachDomain

    /**
     * Attach this object to specified domain class that equals the id
     */
    //String attachId

    String remark

    static mapping = {
        id generator: 'uuid'

        dataUrl type: 'text'
    }

    static constraints = {
		id maxSize: 32
        //attachDomain nullable: true, empty: true
        //attachId nullable: true, empty: true

        thumbnailObjectKey nullable: true
        thumbnailUrl nullable: true

        dataUrl nullable: true
    }

    void setFile(CommonsMultipartFile file) {
        contentType = file.contentType
        contentLength = file.size
        originalFilename = file.originalFilename
    }

    void setFile(File file, String name, String type) {
        contentType = type
        contentLength = file.length()
        originalFilename = name
    }

//    void attach(domain) {
//        attachDomain = domain?.class?.name
//        attachId = domain?.id
//    }

    String getFriendlyUrl() {
        "http://${bucket}/${objectKey}"
    }

    String getUnsecuredUrl() {
        url?.replaceFirst("https://", "http://")
    }
}
