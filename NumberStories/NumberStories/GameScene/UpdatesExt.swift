import SpriteKit

extension GameScene {
    
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
