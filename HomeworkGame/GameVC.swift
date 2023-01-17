//
//  ViewController.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 12/31/22.
//

import GameplayKit
import SpriteKit

class GameVC: UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.systemBlue
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        let skView = SKView()
        skView.showsPhysics = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        view = skView
        skView.presentScene(scene)
    }
}

