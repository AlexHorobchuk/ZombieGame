//
//  GameScenes.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/7/23.
//

import UIKit
import SpriteKit

class GameScene: SKScene {
    //nodes
    var cam = SKCameraNode()
    var player: SKSpriteNode!
    var zombie: SKSpriteNode!
    var bonus: SKSpriteNode!
    var florNode: SKSpriteNode!
    var bg: SKSpriteNode!
    var sceneSize: CGFloat!
    override func didMove(to view: SKView) {
        self.anchorPoint = .init(x: 0, y: 0)
        self.camera = cam
        sceneSize = self.frame.width * 30
        self.addChild(Cloud.populateCloud(at: .init(x: 300, y: self.size.height - 200)))
        setupFlor()
        setupPlayer()
        setupBG()
        cloudGenerator()
    }
    
    func cloudGenerator() {
        self.run(.repeatForever(.sequence([.run {
            self.addChild(Cloud.populateCloud(at: .init(x: self.sceneSize + self.frame.width,
                        y: CGFloat.random(in: (self.frame.maxY * 0.65)...self.frame.maxY))))
        }, .wait(forDuration: TimeInterval(Int.random(in: 8...12)))])))
    }
    
    func setupBG() {
        let bgSize = self.size.width
        let bgQuantity = Int((sceneSize / bgSize).rounded())
        for i in 0...(bgQuantity + 2) {
            bg = SKSpriteNode(texture: .init(imageNamed: "BG") , size: .init(width: bgSize, height: self.size.height))
            bg.position = .init(x: (-self.frame.width / 2) + (bg.frame.width * CGFloat(i)) , y: self.frame.height / 2)
            bg.zPosition = -3
            self.addChild(bg)
        }
    }
    
    func setupPlayer() {
        player = SKSpriteNode(texture: .init(imageNamed: "steady1"))
        let aimWidth: CGFloat = 90
        let ratio = aimWidth / player.size.width
        player.setScale(ratio)
        player.position = .init(x: self.frame.width / 2, y: 100)
        player.physicsBody?.isDynamic = false
        player.physicsBody = .init(rectangleOf: .init(width: player.size.width, height: player.size.height))
        self.addChild(player)
    }
    
    func setupFlor() {
        let florNodeSize: CGFloat = 40
        let bgQuantity = Int((sceneSize / florNodeSize).rounded())
        for i in 0...bgQuantity {
            florNode = SKSpriteNode(texture: .init(imageNamed: "tile"),
                                    size: .init(width: florNodeSize,
                                                height: florNodeSize))
            florNode.position = .init(x: self.frame.width / 2 + (florNode.frame.width * CGFloat(i)), y: 40)
            florNode.physicsBody = .init(rectangleOf: .init(width: 40, height: 40))
            florNode.physicsBody?.isDynamic = false
            florNode.physicsBody?.affectedByGravity = false
            florNode.zPosition = 0
            self.addChild(florNode)
            if i % 6 == 0 {
                self.addChild(Cloud.populateCloud(at: .init(x: florNode.position.x, y: CGFloat.random(in: (self.frame.maxY * 0.65)...self.frame.maxY))))
            }
            
            if i % 3 == 0 || i % 5 == 0 || i % 4 == 0 {
                self.addChild(BackgroundObject.populateObject(at: .init(x: florNode.position.x, y: florNode.position.y + (florNode.frame.height / 2))))
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        cam.position = .init(x: player.position.x, y: self.frame.height / CGFloat(2))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPosition = touch.location(in: self)
            let timeForMove = ((abs(player.position.x - touchPosition.x)) / frame.maxX) * 2
            player.run(.move(to: .init(x: touchPosition.x, y: player.position.y), duration: timeForMove))
        }
    }
}

