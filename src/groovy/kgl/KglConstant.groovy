package kgl

class KglConstant {

    public final static String SESSION_KEY_LATEST_CONTENT_ID = "kgl_session_key_latest_content_id"

    /*
     * Convert original images to smaller size for page load speed up
     */
    public final static int THUMBNAIL_MAX_WIDTH = 600;
    public final static int THUMBNAIL_MAX_HEIGHT = 600;

    /*
     * Tiny thumbnail size for image "data url" (embed in CSS and JavaScript)
     */
    public final static int THUMBNAIL_TINY_MAX_WIDTH = 320;
    public final static int THUMBNAIL_TINY_MAX_HEIGHT = 320;

}
