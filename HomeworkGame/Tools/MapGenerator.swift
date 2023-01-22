//
//  MapGenerator.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/15/23.
//

import UIKit
import SpriteKit
class MapGenerator: SKSpriteNode {
    static func generateMap(at point: CGPoint , player: SKSpriteNode , mapSize: CGSize, isFirstMap: Bool) -> MapGenerator {
        
        let map = MapGenerator()
        map.size = mapSize
        let bg = SKSpriteNode(texture: .init(imageNamed: "BG"), size: mapSize)
        bg.position = .init(x: map.frame.maxX, y: map.frame.maxY)
        bg.zPosition = -5
        map.addChild(bg)
        
        map.anchorPoint = (.init(x: 0, y: 0))
        map.zPosition = -3
        map.position = point
        
        let tileSize: CGSize = .init(width: 50, height: 50)
        let quantityOfTiles = Int(mapSize.width / tileSize.width)
        isFirstMap ? firstflorGenerator(size: mapSize, quantity: quantityOfTiles, tileSize: tileSize, parent: map) : randomFlorGenerator(size: mapSize, quantity: quantityOfTiles, tileSize: tileSize, parent: map)
        
        let erasor = Erasor.generateErasor(at: .init(x: mapSize.width / 2, y: -100),
                                           size: .init(width: mapSize.width, height: 5))
        map.addChild(erasor)
        return map
    }
    
    static func randomFlorGenerator (size: CGSize, quantity: Int, tileSize: CGSize, parent: MapGenerator  ) {
        var randomInt = Int.random(in: 1...10)
        for i in 1...quantity - 1  {
            if i % 2 == 0 {
                randomInt = Int.random(in: 1...10)
                
            }
            let tile = FlorTile.populateTile(with: tileSize, randomInt: randomInt, nodeNumber: i, parent: parent)
            parent.addChild(tile)
            generateBackgroundObjects(i: i, tile: tile)
            tile.position = .init(x: (tile.frame.width / 2 + (tile.frame.width * CGFloat(i))), y: 40)
            FlorTile.modify(florNode: tile, randomInteger: randomInt, nodeNumber: i, parent: parent)
        }
    }
    
    static func firstflorGenerator(size: CGSize, quantity: Int, tileSize: CGSize, parent: MapGenerator  ) {
        for i in 1...quantity - 1 {
            let tile = FlorTile.populateTile(with: tileSize, randomInt: 1, nodeNumber: i, parent: parent)
            parent.addChild(tile)
            generateBackgroundObjects(i: i, tile: tile)
            tile.position = .init(x: (tile.frame.width * CGFloat(i)) + (tile.frame.width / 2), y: 40)
        }
        
        
    }
    
    static func generateBackgroundObjects(i: Int, tile: FlorTile) {
        //adding objets on tile
        if i % 3 == 0 {
            tile.addChild(BackgroundObject.populateObject(at: .init(x: tile.position.x, y: (tile.frame.height / 2))))
            
            tile.parent!.addChild(Cloud.populateCloud(at: .init(x: (tile.frame.width * CGFloat(i)), y: CGFloat.random(in: (tile.parent!.frame.maxY * 0.75)...tile.parent!.frame.maxY))))
        }
        
        if i % 11 == 0 {
            let random = Int.random(in: 1...3)
            if random == 3 {
                tile.addChild(Bonus.generateBonus(at: .init(x: tile.position.x, y: (tile.frame.height / 2))))
            }
        }
    }
}
