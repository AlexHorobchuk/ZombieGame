//
//  Collision.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/14/23.
//

import Foundation
import SpriteKit

struct PhysicCategory {
    static let all  : UInt32 = 0xFFFFFFFF
    static let flor  : UInt32 = 2
    static let player: UInt32 = 4
    static let zombie: UInt32 = 8
    static let zombieRadar: UInt32 = 16
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        var body: SKPhysicsBody
        if contact.bodyA.categoryBitMask == PhysicCategory.player {
            body = contact.bodyB
        } else {
            body = contact.bodyA
        }
        switch body.categoryBitMask {
        case PhysicCategory.flor:
            self.grounded = true
        default:
            return
        }
    }
}
