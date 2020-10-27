import SpriteKit
import GameplayKit

class Marble: SKSpriteNode {
    
    var dragging: Bool = false
    
}

class GameScene: SKScene {
    
    var lRegion: CGRect?
    var rRegion: CGRect?
    
    func initializeGravityFields() {
        lField.position.x = -size.width/4
        rField.position.x = size.width/4
        lField.categoryBitMask = 1
        rField.categoryBitMask = 1
        lField.region = SKRegion(path: .init(rect: lRegion!, transform: nil))
        rField.region = SKRegion(path: .init(rect: rRegion!, transform: nil))
        let n = SKShapeNode(rect: lRegion!)
        let n2 = SKShapeNode(rect: rRegion!)
        n.fillColor = .brown
        n2.fillColor = .green
        n.zPosition = -1
        n2.zPosition = -1
        //addChild(n)
        //addChild(n2)
        let p = SKShapeNode(circleOfRadius: 10)
        let p2 = SKShapeNode(circleOfRadius: 10)
        p.position = lField.position
        p2.position = rField.position
        p.zPosition = -1
        p2.zPosition = -1
        //addChild(p)
        //addChild(p2)
    }
            
    override func didMove(to view: SKView) {
        physicsBody = .init(edgeLoopFrom: CGRect(x: -size.width/2, y: -size.height/2, width: size.width, height: size.height))
        physicsBody?.affectedByGravity = false
        lRegion = CGRect(x: -size.width/4, y: -size.height/2, width: size.width/2, height: size.height)
        rRegion = CGRect(x: -size.width/4, y: -size.height/2, width: size.width/2, height: size.height)
        lCounter.fontSize = size.height * 0.7
        rCounter.fontSize = size.height * 0.7
        positionCounters()
        adjustStory()
        initializeGravityFields()
        addRepulsionToMarbles()
    }
    
    var story: SKNode {
        return childNode(withName: "story")!
    }
    
    func adjustStory() {
        let ratio: CGFloat = 96 / 768
        let fontsize = ratio * size.height
        let width = fontsize
        var i = 0
        for n in story.children.compactMap({ $0 as? SKLabelNode }) {
            n.fontSize = fontsize
            n.position.x += CGFloat(i) * width
            i += 1
        }
        story.position.x -= story.children[2].position.x
        story.position.y = size.height/2 - fontsize
    }
    
    func positionCounters() {
        lCounter.position.x = -size.width/4 - size.width/10
        rCounter.position.x = size.width/4 + size.width/10
        lCounter.position.y = -lCounter.fontSize/3
        rCounter.position.y = -rCounter.fontSize/3
    }
    
    var dragMap: [(UITouch, Marble)] = []
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            print(touch.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        func touchIsOccupied(touch: UITouch) -> Bool {
            return dragMap.contains(where: { $0.0 == touch })
        }
        
        for touch in touches {
            if let n = nodes(at: touch.location(in: self)).first as? Marble {
                n.dragging = true
                n.physicsBody?.velocity = .zero
                n.physicsBody?.angularVelocity = 0
                if !touchIsOccupied(touch: touch) {
                    print(32)
                    dragMap.append((touch, n))
                }
            }
        }
        for drag in dragMap {
            drag.1.position = drag.0.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for dragElement in dragMap {
            if touches.contains(dragElement.0) {
                dragMap = dragMap.filter{ $0 != dragElement }
            }
        }
    }
    
    func addRepulsionToMarbles() {
        let marbleNodes = children.compactMap{ $0 as? Marble }
        for marbleNode in marbleNodes {
            let repulsiveField = SKFieldNode.electricField()
            repulsiveField.strength = 2
            repulsiveField.categoryBitMask = 1
            marbleNode.addChild(repulsiveField)
        }
    }
    
    func updateCounters() {
        let marbleNodes = children.compactMap{ $0 as? Marble }
        let lcount = marbleNodes.filter{ $0.position.x < 0 }.count
        let rcount = marbleNodes.count - lcount
        lCounter.text = "\(lcount)"
        rCounter.text = "\(rcount)"
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateCounters()
        for node in children.compactMap({ $0 as? Marble }) {
            node.physicsBody?.fieldBitMask = dragMap.contains(where: { $0.1 == node }) ? 0 : 1
        }
    }
    
}

extension GameScene {
    var lField: SKFieldNode {
        return childNode(withName: "lField") as! SKFieldNode
    }
    var rField: SKFieldNode {
        return childNode(withName: "rField") as! SKFieldNode
    }
    var cam: SKCameraNode? {
        childNode(withName: "cam") as? SKCameraNode
    }
    var lCounter: SKLabelNode {
        return childNode(withName: "lCounter") as! SKLabelNode
    }
    var rCounter: SKLabelNode {
        return childNode(withName: "rCounter") as! SKLabelNode
    }
}
