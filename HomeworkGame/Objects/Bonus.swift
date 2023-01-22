//
//  Bonus.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/21/23.
//

import UIKit
import SpriteKit
class Bonus: SKSpriteNode {
    static func generateBonus(at point: CGPoint) -> Bonus{
        let bonus = Bonus(texture: .init(imageNamed: "Skeleton"))
        let aimWidth: CGFloat = 70
        let ratio = aimWidth / bonus.size.width
        bonus.position = point
        bonus.setScale(ratio)
        bonus.physicsBody = .init(texture: bonus.texture!, size: bonus.size)
        bonus.physicsBody?.allowsRotation = false
        bonus.physicsBody?.categoryBitMask = PhysicCategory.bonus
        bonus.physicsBody?.collisionBitMask = PhysicCategory.flor
        bonus.physicsBody?.contactTestBitMask = PhysicCategory.player
        return bonus
    }
}
