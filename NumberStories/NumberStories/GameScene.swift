//
//  GameScene.swift
//  NumberStories
//
//  Created by Rankovic, Marko on 02/12/2017.
//  Copyright © 2017 Marko Rankovic. All rights reserved.
//

//        attractor categoryBitMask = 1
//        attractor strength =  5.5
//        attractor falloff = 2
//        attractor minimumRadius = 147
//
//        trayAttractor strength = 100
//        trayAttractor falloff = 2
//        trayAttractor exclusive = true
//
//        mass = 1
//        friction = 0
//        restitution = 0.5
//        linearDamping = 1.5
//        angularDamping = 0.1

import SpriteKit
import QuartzCore.CoreAnimation

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
    
    var leftCounter: SKSpriteNode? { return childNode(withName: "CounterLeft") as? SKSpriteNode }
    var rightCounter: SKSpriteNode? { return childNode(withName: "CounterRight") as? SKSpriteNode }
    var plusCounter: SKSpriteNode? { return childNode(withName: "CounterPlus") as? SKSpriteNode }
    
    var leftAttractor: SKFieldNode? { return childNode(withName: "AttractorLeft") as? SKFieldNode }
    var rightAttractor: SKFieldNode? { return childNode(withName: "AttractorRight") as? SKFieldNode }
    var trayAttractor: SKFieldNode? { return childNode(withName: "AttractorTray") as? SKFieldNode }
    var rewardButton: SKLabelNode? { return childNode(withName: "RewardButton") as? SKLabelNode }
    var menuButton: SKLabelNode? { return childNode(withName: "MenuButton") as? SKLabelNode }
    var soundButton: SKLabelNode? { return childNode(withName: "SoundButton") as? SKLabelNode }
    var background: SKSpriteNode? { return childNode(withName: "Background") as? SKSpriteNode }
    
    let MarbleRadius: CGFloat = 88
    var MarbleMinY: CGFloat { return -size.height / 2 + MarbleRadius / 2 }
    let Padding: CGFloat = 1100
    let TrayHeight: CGFloat = 100
    var TaskTermsHeight: CGFloat { return menuButton?.position.y ?? 327.268 }
    var TrayTop: CGFloat { return -size.height / 2 + TrayHeight }
    
    let MarbleAlpha: CGFloat = 0.95
    let CounterAlpha: CGFloat = 0.1
    let TaskTermAlpha: CGFloat = 0.85
    let TaskTermScale: CGFloat = 0.2
    let TaskTermSep: CGFloat = 20 //
    let TaskOperatorScale: CGFloat = 0.4
    let Dur: TimeInterval = 1
    
    let RewardChars = "🍯 🍎 🍏 🍊 🍋 🍒 🍇 🍉 🍓 🍑 🍈 🍌 🍐 🍍 🍠 🍆 🍅 🌽".components(separatedBy: " ")
    
    override func didMove(to view: SKView) {
        //scaleMode = .aspectFill
        adjustScene()
        adjustCounters()
        adjustAttractors()
        adjustMarbles()
        //adjustMenuButton()
        newTask()
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
                let repulsion = marble.childNode(withName: "repulsion") as? SKFieldNode,
                repulsion.strength != 0
                else { return }
            
            repulsion.strength = 0
        }
    }
    
    func newTask() {
        
        state = .Task
        game.setNewTask()
        
        let leftTexture = SKTexture(imageNamed: String(game.leftTerm))
        let plusTexture = SKTexture(imageNamed: "plus")
        let rightTexture = SKTexture(imageNamed: String(game.rightTerm))
        let equalsTexture = SKTexture(imageNamed: "equals")
        let sumTexture = SKTexture(imageNamed: String(game.storyNumber))
        
        let l = leftTexture.size().width * TaskTermScale
        let p = plusTexture.size().width * TaskOperatorScale
        let r = rightTexture.size().width * TaskTermScale
        let e = equalsTexture.size().width * TaskOperatorScale
        let s = sumTexture.size().width * TaskTermScale
        
        let sep = TaskTermSep
        
        let lx = -(l/2 + sep + p/2)
        let px = CGFloat(0)
        let rx = p/2 + sep + r/2
        let ex = rx + r/2 + sep + e/2
        let sx = ex + e/2 + sep + s/2
        
        let bounce: SKAction = .sequence(
            .scale(by: 1.1, duration: Dur / 2),
            .scale(to: 1, duration: Dur / 2)
        )
        
        func addEqualsAndSum(_ templateNode: SKSpriteNode) {
            
            let equals = copySprite(templateNode)
            equals.name = "TaskTermEquals"
            equals.texture = equalsTexture
            equals.position = CGPoint(x: ex, y: TaskTermsHeight)
            highlight(equals, color: SKColor(hue: 0.14, saturation: 1, brightness: 1, alpha: 0.85))
            equals.alpha = 0
            
            let sum = copySprite(templateNode)
            sum.name = "TaskTermSum"
            sum.texture = sumTexture
            sum.position = CGPoint(x: sx, y: TaskTermsHeight)
            highlight(sum, color: SKColor(hue: 0.4, saturation: 1, brightness: 0.9, alpha: 0.85))
            sum.alpha = 0
            
            var index = 0
            
            func appearInPlace(_ node: SKSpriteNode, texture: SKTexture, scale: CGFloat, audioFileName: String) {
                
                index += 1
                
                addChild(node)
                
                node.run(
                    .sequence(
                        .setTexture(texture, resize: true),
                        .scale(to: scale, duration: 0),
                        .wait(forDuration: Dur * 9 + Dur * TimeInterval(index)),
                        .group(
                            .fadeAlpha(to: TaskTermAlpha, duration: Dur),
                            .playSoundFileNamed(audioFileName, waitForCompletion: true)
                        )
                    )
                )
            }
            
            appearInPlace(equals, texture: equalsTexture, scale: TaskOperatorScale, audioFileName: "equals.caf")
            appearInPlace(sum, texture: sumTexture, scale: TaskTermScale, audioFileName: "sum-\(game.storyNumber).caf")
        }
        
        
        func beamUp(_ node: SKSpriteNode, texture: SKTexture, scale: CGFloat, x: CGFloat, index: Int, audio: SKAction) {
            
            let scale: SKAction = .scale(to: scale, duration: Dur)
            let move: SKAction = .move(to: .init(x: x, y: TaskTermsHeight), duration: Dur)
            
            node.alpha = 0
            addChild(node)
            
            node.run(
                .sequence(
                    .setTexture(texture, resize: true),
                    .wait(forDuration: Dur),
                    .fadeAlpha(to: TaskTermAlpha, duration: Dur),
                    .wait(forDuration: TimeInterval(index) * Dur),
                    .group(bounce, audio),
                    .wait(forDuration: TimeInterval(4 - index) * Dur),
                    .group(scale, move)
                )
            )
        }
        
        for node in taskTerms {
            node.fadeOutAndRemove(forDuration: Dur)
        }
        
        run(
            .sequence(
                .wait(forDuration: Dur * 13),
                .run{ [unowned self] in
                    for marble in self.marbles {
                        marble.run(.fadeAlpha(to: self.MarbleAlpha, duration: self.Dur))
                    }
                    if DidNotSayDragTheMarblesMessageYet {
                        self.run(
                            .sequence(
                                .wait(forDuration: self.Dur),
                                .playSoundFileNamed("drag.caf", waitForCompletion: true)
                            )
                        )
                        DidNotSayDragTheMarblesMessageYet = false
                    }
                }
            )
        )
        
        for counter in counters {
            
            counter.removeAllActions()
//            counter.run(
//                .sequence(
//                    .fadeAlpha(to: 0, duration: Dur),
//                    .wait(forDuration: Dur * 11),
//                    .fadeAlpha(to: CounterAlpha, duration: Dur)
//                )
//            )
            
            let node = copySprite(counter)
            
            switch node.name {
            
            case "CounterLeft"?:
                node.name = "TaskTermLeft"
                highlight(node, color: SKColor(hue: 0.05, saturation: 1, brightness: 1, alpha: 0.85))
                let audio: SKAction = .playSoundFileNamed("left-\(game.leftTerm).caf", waitForCompletion: true)
                beamUp(node, texture: leftTexture, scale: TaskTermScale, x: lx, index: 1, audio: audio)
                
                
            case "CounterPlus"?:
                node.name = "TaskTermPlus"
                highlight(node, color: SKColor(hue: 0.14, saturation: 1, brightness: 1, alpha: 0.85))
                let audio = SKAction.playSoundFileNamed("plus.caf", waitForCompletion: true)
                beamUp(node, texture: plusTexture, scale: TaskOperatorScale, x: px, index: 2, audio: audio)
                
                
            case "CounterRight"?:
                node.name = "TaskTermRight"
                highlight(node, color: SKColor(hue: 0.05, saturation: 1, brightness: 1, alpha: 0.85))
                let audio: SKAction = .playSoundFileNamed("right-\(game.rightTerm).caf", waitForCompletion: true)
                beamUp(node, texture: rightTexture, scale: TaskTermScale, x: rx, index: 3, audio: audio)
                
                addEqualsAndSum(counter)
                
            default:
                break
            }
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
    
    
    
    func giveReward() {
        
        state = .Reward
        
        rewardButton?.fadeOutAndRemove(forDuration: Dur)
        
        for marble in marbles {
            marble.run(.fadeAlpha(to: 0, duration: Dur))
        }
        
        func addBeads(forKey key: String, counter: SKSpriteNode?) {
            
            let scale: CGFloat = 600 / 650.0
            
            if let points = BeadPositions[key] {
                if let counter = counter {
                    for point in points {
                        let x = point.x * scale + counter.position.x
                        let y = point.y * scale
                        
                        let string = RewardChars[randomInt(from: 0, to: RewardChars.count - 1)]
                        let bead = SKLabelNode(text: string)
                        bead.name = "Reward"
                        bead.position = CGPoint(x: x, y: y)
                        bead.zPosition = 1000
                        bead.verticalAlignmentMode = .center
                        bead.fontSize = 32
                        
                        addChild(bead)
                        
                        bead.run(
                            .sequence(
                                .scale(to: 0, duration: 0),
                                .wait(forDuration: TimeInterval(self["Reward"].count) * 0.066),
                                .group(
                                    .playSoundFileNamed("Blop-Mark_DiAngelo-79054334.mp3", waitForCompletion: true),
                                    .scale(to: 1, duration: Dur/4)
                                )
                            )
                        )
                    }
                }
            }
        }
        
        addBeads(forKey: String(game.leftTerm), counter: leftCounter)
        addBeads(forKey: "plus", counter: plusCounter)
        addBeads(forKey: String(game.rightTerm), counter: rightCounter)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
            print("x:\(node.position.x)")
            node.position.y = max(MarbleMinY, node.position.y + translation.dy)
            print("y:\(node.position.y)")
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
    
    var leftMarbles: [SKSpriteNode] = []
    var rightMarbles: [SKSpriteNode] = []
    var trayMarbles: [SKSpriteNode] = []
    
    override func update(_ currentTime: TimeInterval) {
        
        let prevLeftMarblesCount = leftMarbles.count
        let prevRightMarblesCount = rightMarbles.count
        
        updateMarbleLists()
        
        showCorrectness(
            game.test(
                leftTerm: leftMarbles.count,
                rightTerm: rightMarbles.count
            )
        )
        
        if leftMarbles.count != prevLeftMarblesCount {
            updateCounter(counter: leftCounter, number: leftMarbles.count)
            updateAttractorFields(attractor: leftAttractor, marbles: leftMarbles)
        }
        
        if rightMarbles.count != prevRightMarblesCount {
            updateCounter(counter: rightCounter, number: rightMarbles.count)
            updateAttractorFields(attractor: rightAttractor, marbles: rightMarbles)
        }
        
        switchOffMarbleRepulsion(for: trayMarbles)
    }
    
    func updateMarbleLists() {
        
        leftMarbles.removeAll(keepingCapacity: true)
        rightMarbles.removeAll(keepingCapacity: true)
        trayMarbles.removeAll(keepingCapacity: true)
        
        for marble in marbles {
            
            if marble.position.y < TrayTop {
                trayMarbles.append(marble)
            } else if marble.position.x < 0 {
                leftMarbles.append(marble)
            } else {
                rightMarbles.append(marble)
            }
        }
    }
    
    func updateCounter(counter: SKSpriteNode?, number: Int) {
        if let counter = counter {
            counter.removeAllActions()
            counter.run(
                .sequence(
                    .fadeAlpha(to: 0, duration: Dur),
                    .wait(forDuration: Dur),
                    .setTexture(SKTexture(imageNamed: String(number)), resize: true),
                    .fadeAlpha(to: CounterAlpha, duration: Dur)
                )
            )
        }
        if let plus = plusCounter {
            if plus.alpha == 0 {
                plus.run(.fadeAlpha(to: CounterAlpha, duration: Dur))
            }
        }
    }
    
    func updateAttractorFields(attractor: SKFieldNode?, marbles: [SKSpriteNode]) {
        if let attractor = attractor {
            
            var attractorStrength: Float = 0
            var marbleStrength: Float = 0
            
            switch marbles.count {
            case 0...1:  attractorStrength = 5.5; marbleStrength = 0
            case 2...3:  attractorStrength = 13;  marbleStrength = 0
            case 4...7:  attractorStrength = 17;  marbleStrength = 2.5
            case 8...10: attractorStrength = 17;  marbleStrength = 0
            default: print("ERROR: number of marbles counted is \(marbles.count)!")
            }
            
            if attractor.strength != attractorStrength {
                attractor.strength = attractorStrength
            }
            
            for marble in marbles {
                guard
                    let repulsion = marble.childNode(withName: "RepulsionField") as? SKFieldNode,
                    repulsion.strength != marbleStrength
                    else { continue }
                
                repulsion.strength = marbleStrength
            }
        }
    }
}
