//
//  FlorTile.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/15/23.
//

import UIKit
import SpriteKit

class FlorTile: SKSpriteNode {
    static func populateTile(with size: CGSize, randomInt: Int, nodeNumber: Int, parent: MapGenerator) -> FlorTile {
        let tile = FlorTile(texture: .init(imageNamed: "tile"), size: size)
        tile.physicsBody = .init(rectangleOf: size)
        tile.physicsBody!.isDynamic = false
        tile.physicsBody!.categoryBitMask = PhysicCategory.flor
        tile.physicsBody!.collisionBitMask = PhysicCategory.player
        tile.physicsBody!.contactTestBitMask = PhysicCategory.player
        tile.physicsBody!.affectedByGravity = false
        tile.zPosition = 0
        return tile
    }
    
    static func modify(florNode: SKSpriteNode, randomInteger: Int, nodeNumber: Int, parent: MapGenerator) {
        let random = Bool.random()
        switch randomInteger {
        case 1:
            return
        case 2:
            if nodeNumber % 4 != 0 && nodeNumber % 1 != 1 {
                florNode.removeFromParent()
            }
        case 3:
            if nodeNumber % 3 == 0 || nodeNumber % 5 == 0 {
                florNode.position.y += 100
            } else {
                florNode.removeFromParent()
            }
        case 4:
            if random {florNode.position.y += 80 } else {
                florNode.position.y += 150
            }
        case 5:
            if random && nodeNumber % 2 != 0 {florNode.removeFromParent() }
        case 6:
            if random {florNode.run(.repeatForever(.sequence([.move(to: .init(x: florNode.position.x, y: (parent.frame.midY)), duration: 2), .move(to: .init(x: florNode.position.x, y: 60), duration: 2) ])))}
        case 7:
            florNode.position.y += CGFloat.random(in: 0...120)
        case 8:
            if nodeNumber % 3 != 0 {
                florNode.removeFromParent()
            } else {florNode.run(.repeatForever(.sequence([.move(to: .init(x: florNode.position.x, y: (parent.frame.midY)), duration: 2), .move(to: .init(x: florNode.position.x, y: 60), duration: TimeInterval(Int.random(in: 2...5))) ])))}
        case 9:
            florNode.position.y += 70
        default:
            florNode.run(.repeatForever(.sequence([.move(to: .init(x: florNode.position.x, y: (parent.frame.midY)), duration: 2), .move(to: .init(x: florNode.position.x, y: 110), duration: TimeInterval(Int.random(in: 2...5))) ])))}
    }
}
