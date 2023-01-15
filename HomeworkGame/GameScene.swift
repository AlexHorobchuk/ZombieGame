//
//  GameScenes.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/7/23.
//

import UIKit
import SpriteKit
import GameController

class GameScene: SKScene {
    
    
    //conditions
    var playerDirectionRight = true
    var playerState = PlayerStatus.steady(direction: .right)
    var grounded = true
    // controller
    var virtualController: GCVirtualController?
    var controllerXposition: Float = 0
    var controllerYposition: Float = 0
    
    //nodes
    var cam = SKCameraNode()
    var player: SKSpriteNode!
    var florNode: SKSpriteNode!
    var bg: SKSpriteNode!
    var sceneSize: CGFloat!
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .init(x: 0, y: 0)
        self.camera = cam
        sceneSize = self.frame.width * 30
        self.addChild(Cloud.populateCloud(at: .init(x: 300, y: self.size.height - 200)))
        setupMap()
        setupPlayer()
        setupBG()
        cloudGenerator()
        connectController()
        physicsWorld.contactDelegate = self
    }
    
    func cloudGenerator() {
        self.run(.repeatForever(.sequence([.run {
            self.addChild(Cloud.populateCloud(at: .init(x: self.sceneSize + self.frame.width,
                        y: CGFloat.random(in: (self.frame.maxY * 0.75)...self.frame.maxY))))
        }, .wait(forDuration: TimeInterval(Int.random(in: 8...12)))])))
    }
    
    func setupBG() {
        let bgSize = self.size.width
        let bgQuantity = Int((sceneSize / bgSize).rounded())
        for i in 0...(bgQuantity + 2) {
            bg = SKSpriteNode(texture: .init(imageNamed: "BG") , size: .init(width: bgSize, height: self.size.height))
            bg.position = .init(x: (-self.frame.width / 2) + (bg.frame.width * CGFloat(i)) , y: self.frame.height / 2)
            bg.zPosition = -3
            self.addChild(bg)
        }
    }
    
    func setupPlayer() {
        player = SKSpriteNode(texture: .init(imageNamed: "steady1"))
        let aimWidth: CGFloat = 100
        let ratio = aimWidth / player.size.width
        player.setScale(ratio)
        player.position = .init(x: self.frame.width / 2, y: 100)
        player.physicsBody = .init(texture: player.texture!, size: player.size)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = PhysicCategory.player
        player.physicsBody?.collisionBitMask = PhysicCategory.all
        player.physicsBody?.contactTestBitMask = PhysicCategory.flor
        player.physicsBody?.restitution = 0
        self.addChild(player)
        
    }
    
    func setupMap() {
        var randomNumber = 1
        let florNodeSize: CGFloat = 50
        let nodeQuantity = Int((sceneSize / florNodeSize).rounded())
        for i in 1...nodeQuantity {
            
            if i % 2 == 0 && i > 5 {
                randomNumber = Int.random(in: 1...10)
            }
            
            florNode = SKSpriteNode(texture: .init(imageNamed: "tile"),
                                    size: .init(width: florNodeSize,
                                                height: florNodeSize))
            if i % 3 == 0  {
                
                florNode.addChild(BackgroundObject.populateObject(at: .init(x: florNode.position.x, y: (florNode.frame.height / 2))))
            }
            
            florNode.position = .init(x: self.frame.width / 3 + (florNode.frame.width * CGFloat(i)), y: 40)
            florNode.physicsBody = .init(rectangleOf: .init(width: florNodeSize, height: florNodeSize))
            florNode.physicsBody?.isDynamic = false
            florNode.physicsBody!.categoryBitMask = PhysicCategory.flor
            florNode.physicsBody!.collisionBitMask = PhysicCategory.player
            florNode.physicsBody!.contactTestBitMask = PhysicCategory.player
            florNode.physicsBody!.affectedByGravity = false
            florNode.zPosition = 0
            self.addChild(florNode)
            FlorModifire.shared.modify(florNode: florNode, randomInteger: randomNumber, NodeNumber: i)
            
            if i % 6 == 0 {
                self.addChild(Cloud.populateCloud(at: .init(x: florNode.position.x, y: CGFloat.random(in: (self.frame.maxY * 0.75)...self.frame.maxY))))
            }
        }
    }
    
    func connectController() {
        let controllerConfig = GCVirtualController.Configuration()
        controllerConfig.elements = [GCInputLeftThumbstick, GCInputButtonA]
        
        let controller = GCVirtualController(configuration: controllerConfig)
        controller.connect()
        virtualController = controller
    }
    
    override func update(_ currentTime: TimeInterval) {
        cam.position = .init(x: player.position.x, y: self.frame.height / CGFloat(2))
        
        controllerXposition = (virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value)!
        controllerYposition = (virtualController?.controller?.extendedGamepad?.leftThumbstick.yAxis.value)!
        let playerYVelocity = (player.physicsBody?.velocity.dy)!
        print(playerYVelocity)
        movementPicker(grounded: grounded, direction: playerDirectionRight, playerState: playerState, controllerXAxis: controllerXposition, controllerYAxis: controllerYposition)
        let newPlayerStatus = statePicker(controllerXAxis: controllerXposition, ControllerYAxis: controllerYposition, playerVelocityY: playerYVelocity, directionRight: playerDirectionRight, grounded: grounded)
        if newPlayerStatus == playerState {
            return
        } else {
            if controllerXposition != 0 {
                if controllerXposition > 0 { playerDirectionRight = true }
                else { playerDirectionRight = false }
            }
            player.removeAllActions()
            playerState = newPlayerStatus
            activateAnimation(playerStatus: playerState, direction: playerDirectionRight)
        }
    }
    
}

