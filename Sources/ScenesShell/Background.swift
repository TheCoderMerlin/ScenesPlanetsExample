import Foundation
import Scenes
import Igis

class Background : RenderableEntity {
    let image : Image
    
    init() {
        guard let url = URL(string:"https://images-assets.nasa.gov/image/PIA08653/PIA08653~orig.jpg") else {
            fatalError("Failed to create image from specified url")
        }
        image = Image(sourceURL:url)
        super.init(name:"Background")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        canvas.setup(image)
    }

    override func render(canvas:Canvas) {
        if image.isReady {
            canvas.render(image)
        }
    }
}
