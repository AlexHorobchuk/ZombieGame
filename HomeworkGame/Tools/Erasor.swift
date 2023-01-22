//
//  Erasor.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/15/23.
//

import UIKit
import SpriteKit

class Erasor: SKSpriteNode {
    static func generateErasor(at point: CGPoint, size: CGSize) -> Erasor {
        let erasor = Erasor()
        erasor.physicsBody = .init(rectangleOf: size)
        erasor.physicsBody?.isDynamic = false
        erasor.physicsBody?.affectedByGravity = false
        erasor.physicsBody?.allowsRotation = false
        erasor.physicsBody?.categoryBitMask = PhysicCategory.bonus
        erasor.physicsBody?.contactTestBitMask = PhysicCategory.player
        erasor.physicsBody?.collisionBitMask = PhysicCategory.flor
        return erasor
    }

}
