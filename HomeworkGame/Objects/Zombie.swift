//
//  zombie.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/14/23.
//

import UIKit
import SpriteKit

class zombie: SKSpriteNode {
    static func populateZombie() -> SKNode{
        let container = SKShapeNode(circleOfRadius: 350)
        container.physicsBody?.categoryBitMask = PhysicCategory.zombieRadar
        container.physicsBody?.contactTestBitMask = PhysicCategory.player
        let zombie = SKSpriteNode(texture: .init(imageNamed: "Idle1"))
        let aimWidth: CGFloat = 100
        let ratio = aimWidth / zombie.size.width
        return container
    }
    
    enum Side {
        case left
        case right
    }
        
}
