//
//  ObjectsMovementLogic.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/11/23.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func runWithSpeed(speed: Int) {
        player.run(.move(by: .init(dx: speed, dy: 0), duration: 3))
    }
    
    //animatios generator
    func generateAnimation(imagesCount: Int, imageNameRight: String,
                           imageNameLeft: String,direction: Bool,
                           animationSpeed: TimeInterval) -> SKAction {
        
        var texture = [SKTexture]()
        if direction {
            texture = (1...imagesCount).map { int in
                SKTexture(imageNamed: imageNameRight + "\(int)")
            }} else {
                texture = (1...imagesCount).map { int in
                    SKTexture(imageNamed: imageNameLeft + "\(int)")
                }}
        
        return SKAction.animate(with: texture, timePerFrame: animationSpeed)
    }
    
    // When player is resting
    func playerAnimation(direction: Bool) {
        let steadyAnimation = generateAnimation(imagesCount: 10, imageNameRight: "steady", imageNameLeft: "steadyLeft", direction: direction, animationSpeed: 0.1)
        player.run(.repeatForever(steadyAnimation))
    }
    
    // runing animation and action
    func playerRunAnimation(direction: Bool) {
        let animation = generateAnimation(imagesCount: 8, imageNameRight: "run", imageNameLeft: "RunLeft", direction: direction, animationSpeed: 0.05)
        player.run(.repeatForever (animation))
    }
    
    // jumping animation and logic
    func playerJumpAnimation(direction: Bool, grounded: Bool) {
        let animation = generateAnimation(imagesCount: 6, imageNameRight: "jump", imageNameLeft: "JumpLeft", direction: direction, animationSpeed: 0.025)
        if grounded {
            player.run(animation)}
    }
    
    // falling animation
    func playerFalling(direction: Bool) {
        let animation = generateAnimation(imagesCount: 4, imageNameRight: "falling", imageNameLeft: "fallingLeft", direction: direction, animationSpeed: 0.1)
        player.run(animation)
    }
    
    enum Side: Equatable {
        case right
        case left
    }
    
    enum PlayerStatus: Equatable {
        case running(direction: Side)
        case steady(direction: Side)
        case jumping(direction: Side)
        case falling(direction: Side)
    }
    
    func activateAnimation( playerStatus: PlayerStatus, direction: Bool) {
        switch playerStatus{
            
        case PlayerStatus.running(direction: .left), PlayerStatus.running(direction: .right):
            self.playerRunAnimation(direction: direction)
            
        case PlayerStatus.steady(direction: .left), PlayerStatus.steady(direction: .right):
            self.playerAnimation(direction: direction)
            
        case PlayerStatus.jumping(direction: .left), PlayerStatus.jumping(direction: .right):
            self.playerJumpAnimation(direction: direction, grounded: grounded)
            
        case PlayerStatus.falling(direction: .left), PlayerStatus.falling(direction: .right):
            self.playerFalling(direction: direction)
        }
    }
    
    
    func runOrStayPicker(controllerXAxis: Float, directionRight: Bool) -> PlayerStatus {
        if  (-0.2...0.2) ~= controllerXAxis {
            return directionRight ? PlayerStatus.steady(direction: .right) :
            PlayerStatus.steady(direction: .left)
        } else {
            return controllerXAxis > 0 ? PlayerStatus.running(direction: .right) :
            PlayerStatus.running(direction: .left)
        }
        
    }
    
    func statePicker(controllerXAxis: Float, ControllerYAxis: Float, playerVelocityY: CGFloat, directionRight: Bool, grounded: Bool) -> PlayerStatus {
        if playerVelocityY < -20 && !grounded {
//            return runOrStayPicker(controllerXAxis: controllerXAxis, directionRight: directionRight)
            return directionRight ? PlayerStatus.falling(direction: .right) :
            PlayerStatus.falling(direction: .left)
        } else if ControllerYAxis > 0.3 {
            return directionRight ? PlayerStatus.jumping(direction: .right) :
            PlayerStatus.jumping(direction: .left)
        } else {
//            return directionRight ? PlayerStatus.falling(direction: .right) :
//            PlayerStatus.falling(direction: .left)
            return runOrStayPicker(controllerXAxis: controllerXAxis, directionRight: directionRight)
        }
    }
    
    func movementPicker(grounded: Bool, direction: Bool ,playerState: PlayerStatus, controllerXAxis: Float, controllerYAxis: Float ) {
        let controllerX = Int(controllerXAxis * 10)
        let controllerY = Int(controllerYAxis * 10)
        switch playerState {
        case .running(direction: _):
            player.run(.run { self.runWithSpeed(speed: controllerX)})
        case .steady(direction: _):
            return
        case .jumping(direction: _):
            if grounded {
                player.physicsBody?.velocity = .init(dx: controllerX * 30, dy: controllerY * 100)
                self.grounded = false
            }
        case .falling(direction: _):
            player.run(.run { self.runWithSpeed(speed: 5 * (Int(controllerX)))})
        }
    }
}
