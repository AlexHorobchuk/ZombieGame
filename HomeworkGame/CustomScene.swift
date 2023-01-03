//
//  CustomScene.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/2/23.
//

import UIKit
import SpriteKit

class CustomScene: SKScene {
    let flor = SKSpriteNode()
    let florBG = SKEmitterNode(fileNamed: "FireParticle")!
    let backgroundParticals = SKEmitterNode(fileNamed: "SkyParticle")!
    let labelLife = SKLabelNode()
    let labelScore = SKLabelNode()
    
    var score = 0 {didSet {labelScore.text = "Score: \(score)"}}
    var life = 3 {didSet {labelLife.text = "Life: \(life) "}}
    
    override func didMove(to view: SKView) {
    }

    
    func setupflorBG() {
        self.addChild(florBG)
        florBG.zPosition = -1
        florBG.advanceSimulationTime(40)
    }
    func setupFlor () {
        self.addChild(flor)
        flor.size = .init(width: frame.width, height: 2)
        flor.position = .init(x: frame.width / 2, y: 220)
        flor.physicsBody = .init(rectangleOf: .init(width: flor.frame.width, height: flor.frame.height))
        flor.physicsBody?.isDynamic = false
        flor.physicsBody?.affectedByGravity = false
        flor.physicsBody?.categoryBitMask = BitMaskCategory.flor
        flor.physicsBody?.collisionBitMask = .zero
        flor.physicsBody?.contactTestBitMask = BitMaskCategory.objects
    }
    
    func setupLabelLife() {
        self.addChild(labelLife)
        labelLife.fontSize = 30
        labelLife.fontColor = .red
        labelLife.text = "Life: 3"
        labelLife.position = .init(x: frame.minX + 60, y: frame.maxY - 110)
    }
    
    func setupLabelScore() {
        self.addChild(labelScore)
        labelScore.fontSize = 30
        labelScore.fontColor = .red
        labelScore.text = "Score: 0"
        labelScore.position = .init(x: frame.minX + 60, y: labelLife.position.y + 50 )
    }
    
    func setupBackground() {
        self.addChild(backgroundParticals)
        backgroundParticals.zPosition = -2
        backgroundParticals.advanceSimulationTime(40)
    }
}
