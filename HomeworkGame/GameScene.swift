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
    
    //score
    let scoreLabel = SKLabelNode()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    //conditions
    var erasorOn = true
    var playerDirectionRight = true
    var playerState = PlayerStatus.steady(direction: .right)
    var grounded = true
    var mapSize = 3 {
        didSet {
            let map = MapGenerator.generateMap(at: .init(x:(self.frame.width * CGFloat(mapSize)), y: 0), player: player, mapSize: self.frame.size, isFirstMap: false)
            self.addChild(map)
        }
    }
    
    //nodes
    var cam = SKCameraNode()
    var player: SKSpriteNode!
    var erasor = Erasor()
    override func didMove(to view: SKView) {
        self.anchorPoint = .init(x: 0, y: 0)
        self.camera = cam
        setupPlayer()
        generateZombie()
        connectController()
        createMap()
        physicsWorld.contactDelegate = self
        cam.position = .init(x: player.position.x, y: self.frame.height / CGFloat(2))
        setupErasor()
        self.addChild(cam)
        setupScoreLabel()
    }
    
    func gameOver() {
        let gameOverScene = GameOverScene(size: self.size, score: score)
        virtualController?.disconnect()
        view?.presentScene(gameOverScene)
    }
    
    func setupErasor() {
        
        let erasor = Erasor.generateErasor(at: .init(x: -(self.size.width * 2), y: self.frame.maxY), size: .init(width: 5, height: self.frame.height))
        erasor.physicsBody?.isDynamic = true
        self.erasor = erasor
        self.addChild(erasor)
    }
    
    func moveErasor() {
        let action = SKAction.move(to: .init(x: self.cam.position.x - (self.frame.width * 1.5), y: 0), duration: 1)
        if erasorOn {
            self.erasor.run(.sequence([.run {self.erasorOn.toggle()},
                                       .wait(forDuration: 1),
                                       action,
                                       .run {self.erasorOn.toggle()}]))
        }
    }
    
    func setupScoreLabel() {
        scoreLabel.text = "Score: 0"
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = SKColor.black
        cam.addChild(scoreLabel)
        scoreLabel.position = .init(x: cam.frame.width + self.frame.width * 0.3, y: cam.frame.height + self.frame.height * 0.3)
    }
    
    func createMap() {
        for i in 0...mapSize {
            let firstMap = i > 0 ? false : true
            let map = MapGenerator.generateMap(at: .init(x:(self.frame.width * CGFloat(i)), y: 0), player: player, mapSize: self.frame.size, isFirstMap: firstMap)
            self.addChild(map)
        }
    }
    
    func generateZombie() {
        let range = {CGFloat.random(in: (self.player.position.x + 400...self.player.position.x + 1500))}
        let generateZombie = SKAction.run {
            self.addChild(Zombie.populateZombie(at: .init(x: range(), y: self.frame.height * 2), player: self.player))
        }
        self.run(.repeatForever(.sequence([generateZombie, .wait(forDuration: 6)])))
    }
    
    func setupPlayer() {
        player = SKSpriteNode(texture: .init(imageNamed: "steady1"))
        let aimWidth: CGFloat = 100
        let ratio = aimWidth / player.size.width
        player.setScale(ratio)
        player.position = .init(x: self.frame.width / 2, y: 100)
        player.physicsBody = .init(rectangleOf: .init(width: aimWidth * 0.40, height: player.size.height * 0.9))
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = PhysicCategory.player
        player.physicsBody?.collisionBitMask = PhysicCategory.flor
        player.physicsBody?.contactTestBitMask = PhysicCategory.flor | PhysicCategory.zombie | PhysicCategory.erasor
        player.physicsBody?.restitution = 0
        self.addChild(player)
    }
    
    // controller set up
    var virtualController: GCVirtualController?
    var controllerXposition: Float = 0
    var controllerYposition: Float = 0
    func connectController() {
        let controllerConfig = GCVirtualController.Configuration()
        controllerConfig.elements = [GCInputLeftThumbstick]
        
        let controller = GCVirtualController(configuration: controllerConfig)
        controller.connect()
        virtualController = controller
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveErasor()
        
        if cam.position.x < player.position.x {
            cam.position.x = player.position.x
        }
        
        controllerXposition = (virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value)!
        controllerYposition = (virtualController?.controller?.extendedGamepad?.leftThumbstick.yAxis.value)!
        let playerYVelocity = (player.physicsBody?.velocity.dy)!
        
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

