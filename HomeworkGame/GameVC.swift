//
//  ViewController.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 12/31/22.
//

import GameplayKit
import SpriteKit

class GameVC: UIViewController {
    
    let backgroundView = UIImageView(image: UIImage(named: "BG"))
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBG()
        playGameButton()
        
        
        //        let scene = GameScene(size: view.bounds.size)
        //        let skView = SKView()
        //        view = skView
        //        skView.presentScene(scene)
    }
    
    func setupBG() {
        self.view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    func playGameButton() {
        let play = CustomButton()
        play.frame = .init(x: self.view.frame.midX,
                           y: self.view.frame.midY, width: 200, height: 100)
        play.setTitle("Play Game", for: .normal)
        self.view.addSubview(play)
        play.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }
    
    @objc func startGame() {
        let scene = GameScene(size: view.bounds.size)
        let skView = SKView()
        view = skView
        skView.presentScene(scene)
    }
    
    
}

