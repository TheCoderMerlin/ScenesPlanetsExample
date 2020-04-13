import Igis
import Scenes

class IndependentBody : RenderableEntity,
                        EntityMouseDragHandler,
                        EntityMouseDownHandler, EntityMouseUpHandler,
                        MouseUpHandler {
    let activeFillStyle = FillStyle(color:Color(.red))
    let fillStyle : FillStyle
    let circle : Ellipse
    var isActive = false
    
    init(name:String, fillColor:Color, radius:Int) {
        fillStyle = FillStyle(color:fillColor)
        circle = Ellipse(center:Point(), radiusX:radius, radiusY:radius, fillMode:.fill)
        super.init(name:name)
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        circle.center = Point(x:canvasSize.width/2, y:canvasSize.height/2)

        dispatcher.registerEntityMouseDragHandler(handler: self)
        dispatcher.registerEntityMouseDownHandler(handler: self)
        dispatcher.registerEntityMouseUpHandler(handler: self)
        dispatcher.registerMouseUpHandler(handler: self)
    }

    override func teardown() {
        dispatcher.unregisterMouseUpHandler(handler:self)
        dispatcher.unregisterEntityMouseUpHandler(handler:self)
        dispatcher.unregisterEntityMouseDownHandler(handler:self)
        dispatcher.unregisterEntityMouseDragHandler(handler:self)
    }

    override func boundingRect() -> Rect {
        let topLeft = Point(x:circle.center.x - circle.radiusX, y:circle.center.y - circle.radiusY)
        let size    = Size(width:circle.radiusX * 2, height:circle.radiusY * 2)
        return Rect(topLeft:topLeft, size:size)
    }

    override func hitTest(globalLocation:Point) -> Bool {
        let distance = transformedCenter().distance(target:globalLocation)
        let radius = Double(circle.radiusX)
        let hit = distance <= radius
        return hit
    }
    
    override func render(canvas:Canvas) {
        let currentFillStyle = isActive ? activeFillStyle : fillStyle
        canvas.render(currentFillStyle, circle)
    }

    func onEntityMouseDrag(globalLocation:Point, movement:Point) {
        circle.center.moveBy(offset:movement)
    }

    func onEntityMouseDown(globalLocation:Point) {
        isActive = true
    }

    func onEntityMouseUp(globalLocation:Point) {
        isActive = false
    }

    func onMouseUp(globalLocation:Point) {
        isActive = false
    }

    func transformedCenter() -> Point {
        return applyTransforms(toPoint:circle.center)
    }
}
