import SpriteKit

extension GameScene {
    
//    func evaluateMarbleSize(_ touches: Set<UITouch>) {
//        let loc = touches.first!.location(in: self)
//        MarbleRadius += loc.x > 0 ? 10 : -10
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        evaluateMarbleSize(touches)
        guard
            let node = (touches.first?.location(in: self)).map(atPoint),
            let name = node.name
            else { return }

        switch name
        {
        case "Marble":
            guard state == .Task && node.alpha > 0 else { break }
            draggedNode = node
            
        case "MenuButton", "RewardButton":
            draggedNode = node
            
        case "Reward":
            collectReward(reward: node)
            
        default:
            break
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        
        let node = atPoint(location)
        if node.name == "Reward" { print("reward")
            collectReward(reward: node)
        }

        if let node = draggedNode, node.name == "Marble" && node.alpha > 0 {
            let prevLocation = touch.previousLocation(in: self)
            node.physicsBody?.isDynamic = false
            let translation = CGVector(
                dx: location.x - prevLocation.x,
                dy: location.y - prevLocation.y
            )
            node.position.x += translation.dx
            //print("x:\(node.position.x)")
            node.position.y = max(MarbleMinY, node.position.y + translation.dy)
            //print("y:\(node.position.y)")
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        endDrag()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        endDrag(touch: touches.first)
    }
    
    func endDrag(touch: UITouch? = nil) {
        guard let node = draggedNode else {
            return
        }
        
        draggedNode = nil
        
        if node.name == "Marble" {
            node.physicsBody?.isDynamic = true
        }
        
        guard node === (touch?.location(in: self)).map(atPoint) else {
            return
        }
        
        switch node.name {
        case "MenuButton"?: presentMenuScene()
        case "RewardButton"?: giveReward()
        default: break
        }
    }
    
}
