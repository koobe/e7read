package kgl

class MapStyle {

    String name

    String content

    /**
     * Default is image/png
     */
    String previewImageType

    /**
     * Image Content in dataUrl (base64)
     */
    String previewImageContent

    static constraints = {
        name unique: true
    }

    static mapping = {
        content type: 'text'
        previewImageContent type: 'text'
    }
}
