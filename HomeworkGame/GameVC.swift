//
//  ViewController.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 12/31/22.
//

import GameplayKit
import SpriteKit

class GameVC: UIViewController {
    let playGameButton = CustomButton()
    let backgroundView = UIImageView(image: UIImage(named: "BG"))
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = MenuScene(size: view.bounds.size)
        let skView = SKView()
        view = skView
        skView.presentScene(scene)
        
    }
}
