//
//  NodeCreatinManager.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/2/23.
//

import UIKit
import SpriteKit

struct Items {
    
    let objectsName = ["poop", "ghost", "redbull", "bible", "weapon" ,"angel"]
    
    private init() {}
    static let shared = Items()
    
    func createItem() -> CustomSpriteNode {
        func imageName(picker: Int) -> String {
            switch picker {
            case ..<40:
                return objectsName[0]
            case 40..<70:
                return objectsName[1]
            case 70..<75:
                return objectsName[2]
            case 75..<85:
                return objectsName[3]
            case 85..<90:
                return objectsName[4]
            default:
                return objectsName[5]
            }}
        let picker = Int.random(in: 0...100)
        let node = CustomSpriteNode()
        let image = imageName(picker: picker)
        node.usedImage = image
        node.texture = SKTexture(imageNamed: image)
        return node
    }
}
