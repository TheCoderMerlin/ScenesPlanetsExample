import Igis
import Scenes

class DependentBody : IndependentBody {
    weak var targetBody : IndependentBody?
    let distance : Int
    let rotationRate : Double
    var radians = 0.0

    init(name:String, fillColor:Color, radius:Int, targetBody:IndependentBody, distance:Int, rotationRate:Double) {
        self.targetBody = targetBody
        self.distance = distance
        self.rotationRate = rotationRate
        super.init(name:name, fillColor:fillColor, radius:radius)
    }

    override func calculate(canvasSize:Size) {
        guard let targetBody = targetBody else {
            fatalError("targetBody is required")
        }

        // Place this object immediately to the right of the targetBody at the proper distance
        let targetCenter = targetBody.transformedCenter()
        let targetRadius = targetBody.circle.radiusX
        circle.center = Point(x:targetCenter.x + targetRadius + distance + circle.radiusX, y:targetCenter.y)

        // Update transforms
        let preTranslate = Transform(translate:DoublePoint(targetCenter))
        let rotate = Transform(rotateRadians:radians)
        let postTranslate = Transform(translate:DoublePoint(-targetCenter))
        setTransforms(transforms:[preTranslate, rotate, postTranslate])

        // Move around the orbit (but only if our layer says we should)
        guard let layer = layer as? ForegroundLayer else {
            fatalError("ForegroundLayer is required")
        }
        if layer.shouldRevolve {
            radians += rotationRate * Double.pi / 180.0
        }
    }
}
