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
    static let erasor: UInt32 = 1
    static let flor  : UInt32 = 2
    static let player: UInt32 = 4
    static let zombie: UInt32 = 8
    static let map: UInt32 = 16
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
//        var bodyA: SKPhysicsBody
//        var bodyB: SKPhysicsBody
        let bodyA = contact.bodyA.node as? SKSpriteNode
        let bodyB = contact.bodyB.node as? SKSpriteNode
        }
        
        
    func detectCollisionType(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody ) -> PhysicCollisionType {
        switch (bodyA.categoryBitMask, bodyB.categoryBitMask) {
        case (PhysicCategory.player, PhysicCategory.flor), (PhysicCategory.flor, PhysicCategory.player):
            return .playerTile
        case (PhysicCategory.erasor, PhysicCategory.map), (PhysicCategory.map, PhysicCategory.erasor):
            return .eraserMap
        case (_, _):
            return .unknow
        }
    }
    
    func collisionAction(type: PhysicCollisionType, bodyA: SKSpriteNode, bodyB: SKSpriteNode ) {
        switch type {
        case .playerTile:
            self.grounded = true
        case .eraserMap:
            bodyA.physicsBody?.categoryBitMask == PhysicCategory.map ? bodyA.removeFromParent() : bodyB.removeFromParent()
        case .unknow:
            print("unknow collision")
        }
    }
    
    
    enum PhysicCollisionType {
        case playerTile
        case eraserMap
        case unknow
        
    }
}
