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
        let width: CGFloat = size.height * view!.bounds.width / view!.bounds.height
        let rect = CGRect(x: -width/2, y: -size.height/2 + swipeBarHeight, width: width, height: size.height - swipeBarHeight)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
    }
    
    func adjustCounters() {
        
        for node in counters {
            if node.name!.contains("Left") || node.name!.contains("Right") {
                let width: CGFloat = size.height * view!.bounds.width / view!.bounds.height
                node.position.x = node.position.x < 0 ? -width / 4 : width / 4
            }
            node.alpha = 0
            node.blendMode = .add
        }
    }
    
    func adjustAttractors() {
        
        let width: CGFloat = size.height * view!.bounds.width / view!.bounds.height
        
        if let field = leftAttractor {
            field.position.x = -width / 4
            let rect = CGRect(x: -Padding, y: -Padding, width: Padding + abs(field.position.x), height: 2 * Padding)
            field.region = SKRegion(path: UIBezierPath(rect: rect).cgPath)
        }
        
        if let field = rightAttractor {
            field.position.x = width / 4
            let rect = CGRect(x: -field.position.x, y: -Padding, width: Padding + field.position.x, height: 2 * Padding)
            field.region = SKRegion(path: UIBezierPath(rect: rect).cgPath)
        }
        
        if let field = trayAttractor {
            field.isExclusive = true
            let height = -field.position.y + TrayHeight
            field.region = SKRegion(size: CGSize(width: Padding, height: height))
        }
    }
    
    func printValues() {
        let marble = marbles.first!
        let radius = marble.size.width / 2
        let linearDamping = marble.physicsBody!.linearDamping
        let repulsionStrength = (marble.childNode(withName: "RepulsionField") as! SKFieldNode).strength
        let repulsionFalloff = (marble.childNode(withName: "RepulsionField") as! SKFieldNode).falloff
        print("radius: \(radius)")
        print("linearDamping: \(linearDamping)")
        print("repulsionStrength: \(repulsionStrength)")
        print("repulsionFalloff: \(repulsionFalloff)")
        let rAttractorStrength = rightAttractor!.strength
        let rAttractorFalloff = rightAttractor!.falloff
        print("rAttractorStrength: \(rAttractorStrength)")
        print("rAttractorFalloff: \(rAttractorFalloff)")
    }
    
    func adjustMarbles() {
        
        func addRepulsiveField(_ marble: SKSpriteNode, _ bitMaskIndex: Int) {
            let field = SKFieldNode.electricField()
            field.name = "RepulsionField"
            field.strength = 2
            field.falloff = 2
            field.region = SKRegion(radius: Float(MarbleRadius) * 2 * 1.666)
            field.categoryBitMask = 1 << UInt32(bitMaskIndex)
            marble.physicsBody?.fieldBitMask = ~field.categoryBitMask
            marble.physicsBody?.charge = 1
            marble.physicsBody?.linearDamping = 1.5
            marble.addChild(field)
        }
        
        let keepIndexes = randomInts(from: 1, to: 10, count: game.storyNumber)
        
        var bitMaskIndex = 1
        
        for marble in marbles {
            
            marble.physicsBody = .init(circleOfRadius: MarbleRadius)
            marble.size = .init(width: MarbleRadius * 2, height: MarbleRadius * 2)
            
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
