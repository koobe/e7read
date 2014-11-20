@Grab('net.coobird:thumbnailator:0.4.7')
@Grab('org.imgscalr:imgscalr-lib:4.2')
import net.coobird.thumbnailator.resizers.configurations.Rendering
import net.coobird.thumbnailator.Thumbnails

import java.awt.Graphics
import java.awt.Toolkit
import java.awt.image.BufferedImage


def toolkit = Toolkit.getDefaultToolkit()
def toolkitImg = toolkit.createImage("img1.jpg")

while (!toolkit.prepareImage(toolkitImg, toolkitImg.getWidth(null), toolkitImg.getHeight(null), null)) {
    Thread.yield()
}

int width = toolkitImg.getWidth(null)
int height = toolkitImg.getHeight(null)

BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB)
Graphics g = img.getGraphics()
g.drawImage(toolkitImg, 0, 0, null)
g.dispose()

Thumbnails
        .of(img)
        .size(640, 640)
        .outputQuality(0.7)
        .rendering(Rendering.QUALITY)
        .toFile("img1-thumbnailator.jpg")
