//
//  Cloud.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/8/23.
//

import SpriteKit

class Cloud: SKSpriteNode {
    static func populateCloud( at point: CGPoint) -> Cloud {
        let cloudImageName = configureCloudName()
        let cloud = Cloud(imageNamed: cloudImageName)
        cloud.setScale(randomScaleFactor)
        cloud.position = point
        cloud.zPosition = -2
        cloud.run(.repeatForever(.moveBy(x: -1.2, y: 0, duration: 0.1)))
        
        return cloud
    }
    
    
    
    static func configureCloudName() -> String {
        let distribution = Int.random(in: 1...8)
        let imageName = "cloud\(distribution)"
        return imageName
    }
    
    static var randomScaleFactor: CGFloat {
        return CGFloat.random(in: 1...10) / 11
    }
}
