import SpriteKit

extension GameScene {
    
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
            counter.run(
                .sequence(
                    .fadeAlpha(to: 0, duration: Dur),
                    .wait(forDuration: Dur * 11),
                    .fadeAlpha(to: CounterAlpha, duration: Dur)
                )
            )
            
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

}
