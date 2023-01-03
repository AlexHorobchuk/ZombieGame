//
//  Game.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/1/23.
//

import UIKit
import SpriteKit


class GameScene: CustomScene {
    let player = SKSpriteNode(texture: SKTexture(imageNamed: "player"), size: .init(width: 60, height: 60))

    override func didMove(to view: SKView) {
        self.anchorPoint = .init(x: 0.0, y: 0)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        setupBackground()
        setupflorBG()
        setupFlor()
        setupLabelLife()
        setupLabelScore()
        setupPlayer()
        physicsWorld.contactDelegate = self
        self.run(.repeatForever(.sequence([.run { self.setupDropingItems() },
                                           .wait(forDuration: 1.3)])))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPosition = touch.location(in: self)
            let timeForMove = ((abs(player.position.x - touchPosition.x)) / frame.maxX) * 2
            player.run(.move(to: .init(x: touchPosition.x, y: player.position.y), duration: timeForMove))
            player.run(.group([.move(to: .init(x: touchPosition.x, y: player.position.y), duration: timeForMove) , .rotate(byAngle: 10, duration: timeForMove)]))
        }
    }
    
    func bombDidCollideWithPlayer(player: SKSpriteNode?, bomb: CustomSpriteNode?) {
        bomb?.removeFromParentWithParticle()
        collisionAction(node: bomb)
        
    }
    
    func setupDropingItems() {
        let item = Items.shared.createItem()
        self.addChild(item)
        item.position = .init(x: CGFloat.random(in: 0..<self.frame.width), y: self.frame.maxY)

        
    }
    
    func setupPlayer() {
        self.addChild(player)
        player.physicsBody = SKPhysicsBody(circleOfRadius: (player.size.height / 2))
        player.position = .init(x: frame.width / 2, y: flor.position.y + (player.frame.height / 2))
        player.physicsBody?.isDynamic = false
        player.physicsBody?.categoryBitMask = BitMaskCategory.player
        player.physicsBody?.collisionBitMask = .zero
        player.physicsBody?.contactTestBitMask = BitMaskCategory.objects
        print(self.frame)
    }
    
    func collisionAction(node: CustomSpriteNode?){
        switch node?.usedImage {
        case "poop":
            if score > 0 {
                score -= 1
            }
        case "ghost":
            score += 1
        case "redbull":
            let redBull = SKEmitterNode(fileNamed: "RedBullParticle")!
            player.run(.sequence([.run { self.player.addChild(redBull)},
                                  .run { self.player.speed = 3},
                                  .wait( forDuration: 15),
                                  .run { self.player.removeAllChildren()},
                                  .run {self.player.speed = 1}]))
        case "bible":
            life -= 1
        case "weapon":
            life += 1
        default:
            score -= 1
        }
    }
    
}
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if secondBody.categoryBitMask == BitMaskCategory.flor {
            let bomb = firstBody.node as? CustomSpriteNode
            bomb?.removeFromParentWithParticle(particleName: "SmokeParticle")
        } else {
            let player = firstBody.node as? SKSpriteNode
            let bomb = secondBody.node as? CustomSpriteNode
            bombDidCollideWithPlayer(player: player, bomb: bomb)
        }
    }
}
