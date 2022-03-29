//
//  ArcadeGameScene.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import SpriteKit
import SwiftUI

class ArcadeGameScene: SKScene {
    /**
     * # The Game Logic
     *     The game logic keeps track of the game variables
     *   you can use it to display information on the SwiftUI view,
     *   for example, and comunicate with the Game Scene.
     **/
    var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared
    
    // Keeps track of when the last update happend.
    // Used to calculate how much time has passed between updates.
    var lastUpdate: TimeInterval = 0
    var squirrel: SquirrelNode!
//    var scaleFactor: CGFloat!
    
    var leftWood: SKShapeNode!
    var rightWood: SKShapeNode!
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        self.setUpPhysicsWorld()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        // ...
        
        // If the game over condition is met, the game will finish
        if self.isGameOver { self.finishGame() }
        
        // The first time the update function is called we must initialize the
        // lastUpdate variable
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        // Calculates how much time has passed since the last update
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        // Increments the length of the game session at the game logic
        self.gameLogic.increaseSessionTime(by: timeElapsedSinceLastUpdate)
        
        self.lastUpdate = currentTime
    }
    
}

// MARK: - Game Scene Set Up
extension ArcadeGameScene {
    
    private func setUpGame() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        self.gameLogic.setUpGame()
        self.backgroundColor = SKColor.cyan
        createWood()
        createPlayer()
        startRunning()
    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: -1, dy: 0)
        physicsWorld.contactDelegate = self
        
        view?.showsPhysics = true
    }
    
    private func startRunning() {
        self.squirrel.animateRun()
        
    }
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
}

// MARK: - Create PLAYER
extension ArcadeGameScene {
    private func createPlayer() {
        let position = CGPoint(x: leftWood.frame.maxX, y: 200)
        self.squirrel = SquirrelNode(at: position)
        addChild(self.squirrel)
    }
}

// MARK: - Create side wood
extension ArcadeGameScene {
    
    func createWood(){
        let treesNode = SKNode()
        
        leftWood = SKShapeNode(rectOf: CGSize(width: 60, height: self.size.height * 1.5))
        leftWood.name = "cLeftWood"
        leftWood.fillColor = .brown
        leftWood.lineWidth = 0
        leftWood.position = CGPoint(x: self.frame.minX, y: 0)
        leftWood.physicsBody = SKPhysicsBody(rectangleOf: leftWood.frame.size)
        leftWood.physicsBody?.categoryBitMask = PhysicsCategory.cSideWood
        leftWood.physicsBody?.contactTestBitMask = PhysicsCategory.bSquirrel
        leftWood.physicsBody?.collisionBitMask = PhysicsCategory.bSquirrel
        leftWood.physicsBody?.isDynamic = false
        leftWood.physicsBody?.restitution = 0
        addChild(leftWood)
        
        rightWood = SKShapeNode(rectOf: CGSize(width: 60, height: self.size.height * 1.5))
        rightWood.name = "cRightWood"
        rightWood.fillColor = .brown
        rightWood.lineWidth = 0
        rightWood.position = CGPoint(x: self.frame.maxX, y: 0)
        rightWood.physicsBody = SKPhysicsBody(rectangleOf: leftWood.frame.size)
        rightWood.physicsBody?.categoryBitMask = PhysicsCategory.cSideWood
        rightWood.physicsBody?.contactTestBitMask = PhysicsCategory.bSquirrel
        rightWood.physicsBody?.collisionBitMask = PhysicsCategory.bSquirrel
        rightWood.physicsBody?.isDynamic = false
        rightWood.physicsBody?.restitution = 0
        
        addChild(rightWood)
    }
}

// MARK: - Handle Player Inputs
extension ArcadeGameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        squirrel.physicsBody?.applyImpulse(CGVector(dx: physicsWorld.gravity.dx < 0 ? 350 : -350, dy: 0))
        squirrel.animateJump()
        physicsWorld.gravity = CGVector(dx: -physicsWorld.gravity.dx, dy: 0)
    }
}


// MARK: - Game Over Condition
extension ArcadeGameScene {
    
    /**
     * Implement the Game Over condition.
     * Remember that an arcade game always ends! How will the player eventually lose?
     *
     * Some examples of game over conditions are:
     * - The time is over!
     * - The player health is depleated!
     * - The enemies have completed their goal!
     * - The screen is full!
     **/
    
    var isGameOver: Bool {
        // Did you reach the time limit?
        // Are the health points depleted?
        // Did an enemy cross a position it should not have crossed?
        
        return gameLogic.isGameOver
    }
    
    private func finishGame() {
        gameLogic.isGameOver = true
    }
}


// MARK: - Register Score
extension ArcadeGameScene {
    
    private func registerScore() {
    }
}
