//
//  CustomNode.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/2/23.
//

import UIKit
import SpriteKit

struct BitMaskCategory {
    static let player: UInt32 = 1
    static let objects: UInt32 = 2
    static let flor: UInt32 = 4
}

class CustomSpriteNode: SKSpriteNode{
    var usedImage = ""
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: .red, size: .init(width: 60, height: 60))
        setupNode()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNode() {
        let rotation = SKAction.rotate(byAngle: 20, duration: 5)
        physicsBody = SKPhysicsBody(circleOfRadius: (self.size.width / 2))
        physicsBody?.categoryBitMask = BitMaskCategory.objects
        self.run(rotation)
        physicsBody?.collisionBitMask = .zero
        physicsBody?.contactTestBitMask = BitMaskCategory.player
        physicsBody?.contactTestBitMask = BitMaskCategory.flor
        
    }
    
    func removeFromParentWithParticle (particleName: String = "MagicParticle") {
        let part = SKEmitterNode(fileNamed: particleName)!
        part.advanceSimulationTime(0.5)
        part.position = self.position
        self.parent?.addChild(part)
        self.removeFromParent()
    }
}
