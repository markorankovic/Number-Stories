import Slider
import Combine

extension GameScene {
    
    func addSliders() {
        let slider6 = Slider(minValue: 1, maxValue: 2, name: "linearDamping")
        bag.append(slider6.$currentValue.sink { value in
            for marble in self.marbles {
                marble.physicsBody!.linearDamping = value
            }
        })
        slider6.position.x = -400
        slider6.position.y = 140
        addChild(slider6)
        
        let slider = Slider(minValue: 1, maxValue: 100, name: "rF")
        bag.append(slider.$currentValue.sink { value in
            self.rF = value
        })
        slider.position.x = -400
        slider.position.y = 70
        addChild(slider)
        
        let slider2 = Slider(minValue: 0, maxValue: 1, name: "s")
        bag.append(slider2.$currentValue.sink { value in
            self.s = value
        })
        slider2.position.x = -400
        slider2.position.y = 0
        addChild(slider2)
        
        let slider3 = Slider(minValue: 0, maxValue: 10, name: "aS")
        bag.append(slider3.$currentValue.sink { value in
            self.aS = value
        })
        slider3.position.x = -400
        slider3.position.y = -70
        addChild(slider3)
        
        let slider4 = Slider(minValue: 0, maxValue: 7, name: "falloff")
        bag.append(slider4.$currentValue.sink { value in
            self.falloff = value
        })
        slider4.position.x = -400
        slider4.position.y = -140
        addChild(slider4)
        
        let slider5 = Slider(minValue: 147, maxValue: 300, name: "minRadius")
        bag.append(slider5.$currentValue.sink { value in
            self.minRadius = Int(value)
        })
        slider5.position.x = -400
        slider5.position.y = -210
        addChild(slider5)
    }
    
}
