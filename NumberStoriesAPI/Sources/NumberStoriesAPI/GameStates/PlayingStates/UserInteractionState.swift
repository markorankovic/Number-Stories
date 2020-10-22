public class UserInteractionState: GameState {
    
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
    
    public func touchesMoved(_ touches: Set<UITouch>, scene: SKScene) {
        for touch in touches {
            print("\(#function) location: \(touch.location(in: scene))")
            if let draggableNode = (scene.nodes(at: touch.location(in: scene)).first) as? DraggableNode {
                moveDraggable(draggableNode, touch, scene)
            }
        }
        print("___________________________________")
    }

}
