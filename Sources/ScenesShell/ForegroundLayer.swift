import Igis
import Scenes

class ForegroundLayer : Layer {

    let sun      : IndependentBody
    let earth    : DependentBody
    let moon     : DependentBody
    let asteroid : DependentBody

    var shouldRevolve = false

    let margin = Size(width:20, height:20)
    let toggleRevolveButtonSize = Size(width:200, height:50)
    var toggleRevolveButton : Button? = nil 
    
    init() {
        sun      = IndependentBody(name:"Sun", fillColor:Color(.yellow), radius:100)
        earth    = DependentBody(name:"Earth", fillColor:Color(.green), radius:40, targetBody:sun, distance:200, rotationRate:1.0)
        moon     = DependentBody(name:"Moon", fillColor:Color(.white), radius:25, targetBody:earth, distance:50, rotationRate:2.0)
        asteroid = DependentBody(name:"Asteroid", fillColor:Color(.gray), radius:10, targetBody:moon, distance:30, rotationRate:4.0)
        
        super.init(name:"Foreground")
        
        insert(entity:sun, at:.front)
        insert(entity:earth, at:.front)
        insert(entity:moon, at:.front)
        insert(entity:asteroid, at:.front)
    }

    override func preSetup(canvasSize:Size, canvas:Canvas) {
        toggleRevolveButton = Button(name:"Revolve", buttonEventHandler:self.onRevolveButtonPressed,
                                     font:"30pt Arial",
                                     rect:Rect(topLeft:Point(x:canvasSize.center.x - toggleRevolveButtonSize.center.x,
                                                             y:canvasSize.height - toggleRevolveButtonSize.height - margin.height),
                                               size:toggleRevolveButtonSize),
                                     textColor:Color(.blue),
                                     backgroundColor:Color(.white))
        insert(entity:toggleRevolveButton!, at:.front)
    }

    func onRevolveButtonPressed(button:Button) {
        shouldRevolve = !shouldRevolve
    }
}
