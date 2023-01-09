//
//  Tree.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/8/23.
//

import SpriteKit

class BackgroundObject: SKSpriteNode {
    static func populateObject( at point: CGPoint) -> BackgroundObject {
    let objectName = configureObjectName()
    let object = BackgroundObject(imageNamed: objectName)
    object.setScale(randomScaleFactor)
    object.position = point
    object.zPosition = -1
    object.anchorPoint = .init(x: 0.5, y: 0)
    return object
}

static func configureObjectName() -> String {
    let distribution = Int.random(in: 1...13)
    switch distribution {
    case 1...5:
        return "Grass (\(Int.random(in: 1...2)))"
    case 6...7:
        return "Cactus (\(Int.random(in: 1...3)))"
    case 8:
        return "Tree"
    case 9:
        return "Sign"
    case 10:
        return "Stone"
    default:
        return "Bush (\(Int.random(in: 1...2)))"
    }
}

static var randomScaleFactor: CGFloat {
    return CGFloat.random(in: 1...10) / 11
}
}
