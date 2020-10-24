extension DraggableNode {
    func togglePhysics(on: Bool) {
        physicsBody?.isDynamic = on
    }
}

public class UserInteractionState: PlayingState {
    
    override func onEntry(from: GameState?) {
        unlockUserInteraction()
    }
    
    private func unlockUserInteraction() {
        print("User interaction unlocked.")
    }
        
    private func moveNodeTo(_ node: DraggableNode, _ position: CGPoint) {
        node.position = position
    }
    
    private func moveDraggable(_ node: DraggableNode, _ touch: UITouch, _ scene: SKScene) {
        moveNodeTo(node, touch.location(in: scene))
    }
        
    public override func touchesMoved(_ touches: Set<UITouch>, _ scene: SKScene) {
        for touch in touches {
            print("\(#function) location: \(touch.location(in: scene))")
            let draggableNodes = scene.nodes(at: touch.location(in: scene)).compactMap({ $0 as? DraggableNode })
            if let draggableNode = draggableNodes.first {
                draggableNode.togglePhysics(on: false)
                moveDraggable(draggableNode, touch, scene)
            }
        }
        print("___________________________________")
    }
    
    public override func onUpdate(timeInterval: TimeInterval, scene: SKScene) {
        //print(1)
    }

}
