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
    static let mapErasor: UInt32 = 16
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let bodyA = contact.bodyA.node as? SKSpriteNode else {return print("nil")}
        guard let bodyB = contact.bodyB.node as? SKSpriteNode else {return print("nil")}
        let type = detectCollisionType(bodyA: bodyA, bodyB: bodyB)
            collisionActionSwitch(type: type, bodyA: bodyA, bodyB: bodyB)
        }
    
    
    func detectCollisionType(bodyA: SKSpriteNode, bodyB: SKSpriteNode ) -> PhysicCollisionType {
        switch (bodyA.physicsBody?.categoryBitMask, bodyB.physicsBody?.categoryBitMask) {
        case (PhysicCategory.player, PhysicCategory.flor), (PhysicCategory.flor, PhysicCategory.player):
            return .playerTile
        case (PhysicCategory.erasor, PhysicCategory.flor), (PhysicCategory.flor, PhysicCategory.erasor):
            return .eraserMap
        case(PhysicCategory.erasor, PhysicCategory.zombie), (PhysicCategory.zombie, PhysicCategory.erasor):
            return .eraserZombie
        case(PhysicCategory.erasor, PhysicCategory.player), (PhysicCategory.player, PhysicCategory.erasor):
            return .playerEraser
        case (_, _):
            return .unknow
        }
    }
    
    func collisionActionSwitch(type: PhysicCollisionType, bodyA: SKSpriteNode, bodyB: SKSpriteNode ) {
        switch type {
        case .playerTile:
            self.grounded = true
        case .eraserMap:
            bodyA.physicsBody?.categoryBitMask == PhysicCategory.flor ? bodyA.parent?.removeFromParent() : bodyB.parent?.removeFromParent()
            print("l")
        case .eraserZombie:
            bodyA.physicsBody?.categoryBitMask == PhysicCategory.zombie ? bodyA.removeFromParent() : bodyB.removeFromParent()
        case.playerEraser:
            bodyA.physicsBody?.categoryBitMask == PhysicCategory.player ? bodyA.removeFromParent() : bodyB.removeFromParent()
        case .unknow:
            print("unknow collision")
        }
    }
    
    enum PhysicCollisionType {
        case playerEraser
        case playerTile
        case eraserMap
        case unknow
        case eraserZombie
        
    }
}
