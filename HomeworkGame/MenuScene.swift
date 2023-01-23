//
//  MenuScene.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/22/23.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    let recordLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    let playLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    let container = SKShapeNode(rectOf: .init(width: 180, height: 70), cornerRadius: 20)
    override func didMove(to view: SKView) {
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        
        let BG = SKSpriteNode(texture: .init(imageNamed: "BG"), size: self.size)
        BG.zPosition = -1
        self.addChild(BG)
        
        setupRecordLabel()
        setupPlayLabel()
    }
    
    func setupRecordLabel() {
        let score = UserDefaultsManager.shared.getUserDefaultScore()
        recordLabel.text = "All time record is \(score)"
        recordLabel.fontSize = 32
        recordLabel.fontColor = SKColor.black
        recordLabel.position.y = self.frame.maxY * 0.5
        self.addChild(recordLabel)
    }
    
    func setupPlayLabel() {
        playLabel.text = "Play"
        playLabel.fontSize = 34
        playLabel.fontColor = SKColor.white
        playLabel.position.y = self.frame.midY - playLabel.frame.midY
        container.position.y = self.frame.midY
        container.fillColor = SKColor.blue
        container.addChild(playLabel)
        self.addChild(container)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        if CGRectContainsPoint(container.frame, location) {
            let gameScene = GameScene(size: (view?.bounds.size)!)
            view?.presentScene(gameScene)
        }
    }
    
}
