import SpriteKit

extension GameScene {
    
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

}
