package kgl

import grails.transaction.Transactional
import net.coobird.thumbnailator.Thumbnails
import net.coobird.thumbnailator.resizers.configurations.Rendering

import java.awt.Graphics
import java.awt.Toolkit
import java.awt.image.BufferedImage

@Transactional
class ImageService {

    private final static float __DEFAULT_THUMBNAIL_QUALITY = 0.7

    def thumbnail(InputStream is, OutputStream os) {
        Thumbnails.of(fixImage(is)).size(640, 640).outputQuality(__DEFAULT_THUMBNAIL_QUALITY).rendering(Rendering.QUALITY).outputFormat('jpg').toOutputStream(os)
    }

    private BufferedImage fixImage(InputStream is) {

        def tk = Toolkit.getDefaultToolkit()
        def tkImg = tk.createImage(is.bytes)

        while (!tk.prepareImage(tkImg, tkImg.getWidth(null), tkImg.getHeight(null), null)) {
            Thread.yield()
        }

        int width = tkImg.getWidth(null)
        int height = tkImg.getHeight(null)

        BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB)
        Graphics g = img.getGraphics()
        g.drawImage(tkImg, 0, 0, null)
        g.dispose()

        return img
    }
}
