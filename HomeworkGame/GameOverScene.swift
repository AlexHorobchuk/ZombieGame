//
//  GameOverScene.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/22/23.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    init(size: CGSize, score: Int) {
        self.score = score
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var score: Int
    let gameOverLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    let scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    let menuLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    let restartLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        
        let BG = SKSpriteNode(texture: .init(imageNamed: "BG"), size: self.size)
        BG.zPosition = -1
        self.addChild(BG)
        
        setupLabel()
        setupGOLabel()
        setupRestartLabel()
        setupMenuLabel()
    }
    
    let shakeButtonAction = SKAction.sequence([.scale(by: 1.25, duration: 0.2), .scale(by: 0.8, duration: 0.2)])
    func setupGOLabel() {
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.fontSize = 35
        gameOverLabel.fontColor = SKColor.black
        gameOverLabel.position.y = scoreLabel.position.y + (gameOverLabel.frame.height * 1.20)
        self.addChild(gameOverLabel)
    }
    
    func setupLabel() {
        let oldRecord = UserDefaultsManager.shared.getUserDefaultScore()
        if oldRecord < score {
            UserDefaultsManager.shared.setUserDefaultScore(value: score)
            scoreLabel.text = "You set a new record! Score: \(score)"
        } else {
            scoreLabel.text = "Your Score: \(score)"
        }
        scoreLabel.fontSize = 32
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position.y = self.frame.maxY * 0.3
        self.addChild(scoreLabel)
    }
    
    
    
    func setupRestartLabel() {
        restartLabel.text = "Restart"
        restartLabel.fontSize = 30
        restartLabel.fontColor = SKColor.black
        restartLabel.position.y = self.frame.midY
        restartLabel.run(.repeatForever(shakeButtonAction))
        self.addChild(restartLabel)
    }
    
    func setupMenuLabel() {
        menuLabel.text = "Go to menu"
        menuLabel.fontSize = 30
        menuLabel.fontColor = SKColor.black
        menuLabel.position.y =  self.frame.minY / 2
        menuLabel.run(.repeatForever(shakeButtonAction))
        self.addChild(menuLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        if CGRectContainsPoint(restartLabel.frame, location) {
            let gameScene = GameScene(size: (view?.bounds.size)!)
            view?.presentScene(gameScene)
        }
        if CGRectContainsPoint(menuLabel.frame, location) {
            let menuScene = MenuScene(size: (view?.bounds.size)!)
            view?.presentScene(menuScene)
        }
        
    }
    
}
