//
//  MenuScene.swift
//  NumberStories
//
//  Created by Rankovic, Marko (Developer) on 02/12/2017.
//  Copyright © 2017 Marko Rankovic. All rights reserved.
//

import SpriteKit

var DidNotSayWelcomeMessageYet = true

class MenuScene: SKScene {
    
    override func didMove(to: SKView) {
        
        func makeTouchAreasInvisible() {
            for node in children where node.name?.hasPrefix("touchArea") ?? false {
                node.alpha = 0.01
            }
        }
        
        func speak() {
            var sequence: [SKAction] = []
            if DidNotSayWelcomeMessageYet {
                DidNotSayWelcomeMessageYet = false
                sequence += [
                    .wait(forDuration: 1),
                    .playSoundFileNamed("welcome.caf", waitForCompletion: true)
                ]
            }
            sequence += [
                .wait(forDuration: 2),
                .playSoundFileNamed("chose.caf", waitForCompletion: true)
            ]
            run(.sequence(sequence))
        }
        
        makeTouchAreasInvisible()
        speak()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        if let number = getNumberTouched(at: point) {
            presentGameScene(storyNumber: number)
        }
    }
    
    func presentGameScene(storyNumber number: Int) {
        UserDefaults.standard.set(number, forKey: StoryNumberKey) 
        
        let scene = SKScene(fileNamed: "GameScene")!
        scene.scaleMode = .aspectFill
        
        let transition = SKTransition.push(with: .up, duration: 1)
        transition.pausesIncomingScene = false
        transition.pausesOutgoingScene = false
        
        view?.presentScene(scene, transition: transition)
    }
    
    func getNumberTouched(at point: CGPoint) -> Int? {
        let node = atPoint(point)
        guard
            let name = node.name,
            name.hasPrefix("touchArea-"),
            let numberString = name.components(separatedBy: "-").last,
            let number = Int(numberString)
            else { return nil }
        
        return number
    }
}

