import Igis
import Scenes


class Button : RenderableEntity, EntityMouseClickHandler {
    typealias ButtonEventHandler = (Button) -> Void
    
    let text : Text
    let buttonEventHandler : ButtonEventHandler
    let rectangle : Rectangle
    let textColor : Color
    let backgroundColor : Color
    let outlineColor : Color

    init(name:String, buttonEventHandler: @escaping ButtonEventHandler,
         font:String, rect:Rect,
         textColor:Color, backgroundColor:Color, outlineColor:Color = Color(.black)) {
        text = Text(location:rect.center, text:name)
        text.font = font
        text.alignment = .center
        text.baseline = .middle

        self.buttonEventHandler = buttonEventHandler

        self.rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)

        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.outlineColor = outlineColor
        
        super.init(name:"Button:\(name)")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        dispatcher.registerEntityMouseClickHandler(handler:self)
    }

    override func teardown() {
        dispatcher.unregisterEntityMouseClickHandler(handler:self)
    }

    override func boundingRect() -> Rect {
        return rectangle.rect
    }

    override func render(canvas:Canvas) {
        let textStyle = FillStyle(color:textColor)
        let backgroundStyle = FillStyle(color:backgroundColor)
        let outlineStyle = StrokeStyle(color:outlineColor)
        canvas.render(outlineStyle, backgroundStyle, rectangle, textStyle, text)
    }

    func onEntityMouseClick(globalLocation:Point) {
        buttonEventHandler(self)
    }
    
}
