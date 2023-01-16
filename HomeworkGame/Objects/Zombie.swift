//
//  zombie.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/14/23.
//

import UIKit
import SpriteKit

class Zombie: SKSpriteNode {
    static func populateZombie(at point: CGPoint, player: SKSpriteNode) -> Zombie{
        let zombie = Zombie(texture: .init(imageNamed: "Idle1"))
        let aimWidth: CGFloat = 70
        let ratio = aimWidth / zombie.size.width
        zombie.position = point
        zombie.setScale(ratio)
        zombie.physicsBody = .init(texture: zombie.texture!, size: zombie.size)
        zombie.physicsBody?.allowsRotation = false
        zombie.physicsBody?.categoryBitMask = PhysicCategory.zombie
        zombie.physicsBody?.collisionBitMask = PhysicCategory.all
        zombie.physicsBody?.contactTestBitMask = PhysicCategory.player
        zombie.physicsBody?.restitution = 0
        zombie.run(.repeatForever(startingAnimation()))
        zombie.run(.repeatForever(moveToPlayer(player: player, zombie: zombie)))
        return zombie
    }
    
    
    static func generateZombieAnimation(imagesCount: Int, imageNameRight: String,
                                  imageNameLeft: String,direction: Bool,
                                  animationSpeed: TimeInterval) -> SKAction {
        
        var texture = [SKTexture]()
        if direction {
            texture = (1...imagesCount).map { int in
                SKTexture(imageNamed: imageNameRight + "\(int)")
            }} else {
                texture = (1...imagesCount).map { int in
                    SKTexture(imageNamed: imageNameLeft + "\(int)")
                }}
        
        return SKAction.animate(with: texture, timePerFrame: animationSpeed)
    }
    
    static func startingAnimation() -> SKAction {
        let randomBool = Bool.random()
        return generateZombieAnimation(imagesCount: 15, imageNameRight: "Idle", imageNameLeft: "IdleLeft", direction: randomBool, animationSpeed: 0.2)
    }
    
    static func moveToPlayer(player: SKSpriteNode, zombie: Zombie) -> SKAction {
        var moveRight: Bool {
            zombie.position.x < player.position.x ? true : false
            }
        let speed = moveRight ? 5 : -5
        let animation = generateZombieAnimation(imagesCount: 10, imageNameRight: "Walk", imageNameLeft: "WalkLeft", direction: moveRight, animationSpeed: 0.2)
        let walk = SKAction.move(by: .init(dx: speed, dy: 0), duration: 0.3)
        return SKAction.sequence([animation, walk])
        }
    

        
}