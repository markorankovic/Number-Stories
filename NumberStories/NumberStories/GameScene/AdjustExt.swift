import SpriteKit

extension GameScene {
    
    func adjustBackground() {
        background.size = .init(
            width: size.height * view!.bounds.width / view!.bounds.height,
            height: size.height
        )
    }
    
    func adjustMenuButton() {
        let width: CGFloat = size.height * view!.bounds.width / view!.bounds.height
        menuButton!.position.x = -width/2 + menuButton!.fontSize
    }
    
    func adjustScene() {
        let rect = CGRect(x: -Padding, y: -size.height / 2 + 20, width: 2 * Padding, height: Padding)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
    }
    
    func adjustCounters() {
        
        for node in counters {
            node.alpha = 0
            node.blendMode = .add
        }
    }
    
    func adjustAttractors() {
        
        if let field = leftAttractor {
            let rect = CGRect(x: -Padding, y: -Padding, width: Padding + abs(field.position.x), height: 2 * Padding)
            field.region = SKRegion(path: UIBezierPath(rect: rect).cgPath)
        }
        
        if let field = rightAttractor {
            let rect = CGRect(x: -field.position.x, y: -Padding, width: Padding + field.position.x, height: 2 * Padding)
            field.region = SKRegion(path: UIBezierPath(rect: rect).cgPath)
        }
        
        if let field = trayAttractor {
            field.isExclusive = true
            let height = -field.position.y + TrayHeight
            field.region = SKRegion(size: CGSize(width: Padding, height: height))
        }
    }
    
    func adjustMarbles() {
        
        func addRepulsiveField(_ marble: SKSpriteNode, _ bitMaskIndex: Int) {
            let field = SKFieldNode.electricField()
            field.name = "RepulsionField"
            field.strength = 2
            field.falloff = 2
            field.region = SKRegion(radius: Float(MarbleRadius) * 1.666)
            field.categoryBitMask = 1 << UInt32(bitMaskIndex)
            marble.physicsBody?.fieldBitMask = ~field.categoryBitMask
            marble.physicsBody?.charge = 1
            marble.addChild(field)
        }
        
        let keepIndexes = randomInts(from: 1, to: 10, count: game.storyNumber)
        
        var bitMaskIndex = 1
        
        for marble in marbles {
            
            if keepIndexes.contains(bitMaskIndex) {
                marble.alpha = 0
                marble.physicsBody?.mass = 1
                addRepulsiveField(marble, bitMaskIndex)
            }
            else {
                marble.removeFromParent()
            }
            bitMaskIndex += 1
        }
    }
    
}
