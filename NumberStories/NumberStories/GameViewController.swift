//
//  GameViewController.swift
//  NumberStories
//
//  Created by Rankovic, Marko on 02/12/2017.
//  Copyright © 2017 Marko Rankovic. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

let StoryNumberKey = "StoryNumber"

extension SKView {
    open override var safeAreaInsets: UIEdgeInsets {
        return .zero
    }
}

class GameViewController: UIViewController {
    
    var gameView: SKView { return view as! SKView }

    override var prefersStatusBarHidden: Bool { return true }
        
    override func viewDidLoad() {
        gameView.ignoresSiblingOrder = true
        if let scene = SKScene(fileNamed: "MenuScene") {
            gameView.showsFPS = false
            scene.scaleMode = .fill
            gameView.presentScene(scene)
        }
        #if DEBUG
            gameView.showsFPS = true
            gameView.showsNodeCount = true
        #endif
    }
}
