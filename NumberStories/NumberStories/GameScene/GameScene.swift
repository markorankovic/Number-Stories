import SpriteKit
import QuartzCore.CoreAnimation
import Combine

var DidNotSayDragTheMarblesMessageYet = true

class GameScene: SKScene {
    
    enum State {
        case New
        case Task
        case Reward
    }
    
    var state: State = .New
    let game = Game(storyNumber: UserDefaults.standard.integer(forKey: StoryNumberKey))
    
    var marbles: [SKSpriteNode] { return self["Marble"] as! [SKSpriteNode] }
    var counters: [SKSpriteNode] { return self["Counter*"] as! [SKSpriteNode] }
    var taskTerms: [SKSpriteNode] { return self["TaskTerm*"] as! [SKSpriteNode] }
    var attractors: [SKFieldNode] { return self["Attractor*"] as! [SKFieldNode] }
    
    var background: SKSpriteNode { return childNode(withName: "Background") as! SKSpriteNode }
    var leftCounter: SKSpriteNode? { return childNode(withName: "CounterLeft") as? SKSpriteNode }
    var rightCounter: SKSpriteNode? { return childNode(withName: "CounterRight") as? SKSpriteNode }
    var plusCounter: SKSpriteNode? { return childNode(withName: "CounterPlus") as? SKSpriteNode }
    
    var leftAttractor: SKFieldNode? { return childNode(withName: "AttractorLeft") as? SKFieldNode }
    var rightAttractor: SKFieldNode? { return childNode(withName: "AttractorRight") as? SKFieldNode }
    var trayAttractor: SKFieldNode? { return childNode(withName: "AttractorTray") as? SKFieldNode }
    var rewardButton: SKLabelNode? { return childNode(withName: "RewardButton") as? SKLabelNode }
    var menuButton: SKLabelNode? { return childNode(withName: "MenuButton") as? SKLabelNode }
    var soundButton: SKLabelNode? { return childNode(withName: "SoundButton") as? SKLabelNode }
    let swipeBarHeight: CGFloat = 20
    var MarbleRadius: CGFloat {
        let width = size.height * view!.bounds.width / view!.bounds.height
        return width / 10 / 3.1
    }
    var MarbleMinY: CGFloat { return -size.height / 2 + MarbleRadius / 2 }
    let Padding: CGFloat = 1100
    var TrayHeight: CGFloat { return size.height / 4 }
    var TaskTermsHeight: CGFloat { return menuButton?.position.y ?? 327.268 }
    var TrayTop: CGFloat { return -size.height / 2 + TrayHeight }
    
    let MarbleAlpha: CGFloat = 0.95
    let CounterAlpha: CGFloat = 0.1
    let TaskTermAlpha: CGFloat = 0.85
    let TaskTermScale: CGFloat = 0.2
    let TaskTermSep: CGFloat = 20
    let TaskOperatorScale: CGFloat = 0.4
    let Dur: TimeInterval = 1
    
    let RewardChars = "🍯 🍎 🍏 🍊 🍋 🍒 🍇 🍉 🍓 🍑 🍈 🍌 🍐 🍍 🍠 🍆 🍅 🌽".components(separatedBy: " ")
    
    var bag: [Cancellable] = []
    
    var s: CGFloat = 0
    var rF: CGFloat = 0
    var aS: CGFloat = 0
    var falloff: CGFloat = 2
    var minRadius = 147

    override func didMove(to view: SKView) {
        scaleMode = .aspectFill
        adjustScene()
        adjustCounters()
        adjustAttractors()
        adjustMarbles()
        adjustMenuButton()
        adjustBackground()
        newTask()
        //addSliders()
    }
    
    func copySprite(_ node: SKSpriteNode) -> SKSpriteNode {
        let c = node.copy() as! SKSpriteNode
        c.removeAllActions()
        return c
    }
    
    func fade(_ node: SKNode, toAlpha alpha: CGFloat, duration: TimeInterval, after: TimeInterval = 0) {
        node.run(
            .sequence(
                .wait(forDuration: after),
                .fadeAlpha(to: alpha, duration: duration)
            )
        )
    }
    
    func highlight(_ node: SKSpriteNode, color: SKColor) {
        node.color = color
        node.blendMode = .alpha
        node.colorBlendFactor =  1
    }
    
    func setTexture(to node: SKSpriteNode, imageNamed imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        node.size = texture.size()
        node.texture = texture
    }
    
    func switchOffMarbleRepulsion(for marbles: [SKNode]) {
        for marble in marbles {
            guard
                let repulsion = marble.childNode(withName: "RepulsionField") as? SKFieldNode,
                repulsion.strength != 0
                else { return }
            
            repulsion.strength = 0
        }
    }
    
    func showCorrectness(_ correct: Bool) {
        
        func addRewardButton() {
            let button = SKLabelNode(text: "🎁")
            button.name = "RewardButton"
            button.verticalAlignmentMode = .center
            button.position = CGPoint()
            button.fontSize = MarbleRadius
            button.alpha = 0
            self.addChild(button)
            button.run(.fadeAlpha(to: 1, duration: Dur))
        }
        
        if correct {
            if state == .Task && rewardButton == nil {
                addRewardButton()
            }
        } else {
            rewardButton?.fadeOutAndRemove(forDuration: Dur)
        }
    }

    var timeOfLastMunch: CFTimeInterval = 0
    
    func collectReward(reward node: SKNode) {
        
        node.name? += "Removed"
        var actionGroup: [SKAction] = [.fadeAlpha(to: 0, duration: Dur / 4)]
        let playMunchSound = SKAction.playSoundFileNamed("Apple_Bite-Simon_Craggs-1683647397.mp3", waitForCompletion: true)
        
        let t = CACurrentMediaTime()
        if (t - timeOfLastMunch) > 0.25 {
            actionGroup.append(playMunchSound)
            timeOfLastMunch = t
        }
        
        node.run(
            .sequence(
                .group(actionGroup),
                .removeFromParent()
            )
        )
        
        if self["Reward"].count == 0 {
            run(
                .sequence(
                    .group(
                        .wait(forDuration: Dur),
                        .playSoundFileNamed("Metal_Gong-Dianakc-109711828.mp3", waitForCompletion: false)
                    ),
                    .run{[unowned self] in self.newTask() }
                )
            )
        }
    }
    
    func presentMenuScene() {
        UserDefaults.standard.set(0, forKey: StoryNumberKey)
        
        if let menuScene = SKScene(fileNamed: "MenuScene") as? MenuScene {
            menuScene.scaleMode = .fill
            let transition = SKTransition.push(with: .down, duration: 1)
            transition.pausesIncomingScene = false
            transition.pausesOutgoingScene = false
            self.view?.presentScene(menuScene, transition: transition)
        }
    }
    
    var draggedNode: SKNode?
            
    var leftMarbles: [SKSpriteNode] = []
    var rightMarbles: [SKSpriteNode] = []
    var trayMarbles: [SKSpriteNode] = []
    
}
