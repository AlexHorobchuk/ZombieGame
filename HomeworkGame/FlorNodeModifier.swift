//
//  FlorNodeModifier.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/8/23.
//

import SpriteKit

struct FlorModifire {
    private init (){}
    static let  shared = FlorModifire()
    
    func modify(florNode: SKSpriteNode, randomInteger: Int, NodeNumber: Int) {
        let random = Bool.random()
        switch randomInteger {
        case 1:
            return
        case 2:
            if NodeNumber % 4 != 0 && NodeNumber % 1 != 1 {
                florNode.removeFromParent()
            }
        case 3:
            if NodeNumber % 3 == 0 || NodeNumber % 5 == 0 {
                florNode.position.y += 100
            } else {
                florNode.removeFromParent()
            }
        case 4:
            if random {florNode.position.y += 80 } else {
                florNode.position.y += 150
            }
        case 5:
            if random && NodeNumber % 2 != 0 {florNode.removeFromParent() }
        case 6:
            if random {florNode.run(.repeatForever(.sequence([.move(to: .init(x: florNode.position.x, y: (florNode.parent?.frame.midY)!), duration: 2), .move(to: .init(x: florNode.position.x, y: 60), duration: 2) ])))}
        case 7:
            florNode.position.y += CGFloat.random(in: 0...120)
        case 8:
            if NodeNumber % 3 != 0 {
                florNode.removeFromParent()
            } else {florNode.run(.repeatForever(.sequence([.move(to: .init(x: florNode.position.x, y: (florNode.parent?.frame.midY)!), duration: 2), .move(to: .init(x: florNode.position.x, y: 60), duration: TimeInterval(Int.random(in: 2...5))) ])))}
        case 9:
            florNode.position.y += 70
        default:
            florNode.run(.repeatForever(.sequence([.move(to: .init(x: florNode.position.x, y: (florNode.parent?.frame.midY)!), duration: 2), .move(to: .init(x: florNode.position.x, y: 110), duration: TimeInterval(Int.random(in: 2...5))) ])))}
    }
}
    

