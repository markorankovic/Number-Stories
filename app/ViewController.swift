//
//  ViewController.swift
//  app
//
//  Created by Marko Rankovic on 9/11/20.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(fileNamed: "GameScene")
        (view as? SKView)?.presentScene(scene)
    }
    
}
