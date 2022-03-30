//
//  ArcadeGameScene.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import AVFoundation
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
    let frameSpawner = FrameSpawner()
    // Keeps track of when the last update happend.
    // Used to calculate how much time has passed between updates.
    var lastUpdate: TimeInterval = 0
    var squirrel: SquirrelNode!
//    var scaleFactor: CGFloat!
        
    var treeNode: TreesNode!
    
    let pickUpSound = SKAction.playSoundFileNamed(SoundFile.pickUpSound, waitForCompletion: false)

    var backgroundMusicAV : AVAudioPlayer!
    
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        self.setUpPhysicsWorld()
        self.frameSpawner.startCreatingObstacles()
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
        addChild(frameSpawner)
        createWood()
        createPlayer()
        startRunning()
    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: -10, dy: 0)
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
        var position = CGPoint.zero
        if let leftTree = treeNode.childNode(withName: "cLeftWood") as? SKShapeNode {
            position = CGPoint(x: leftTree.frame.maxX, y: 200)
        }
        
        self.squirrel = SquirrelNode(at: position)
        addChild(self.squirrel)
    }
}

// MARK: - Create side wood
extension ArcadeGameScene {
    
    func createWood(){
        treeNode = TreesNode()
        addChild(treeNode)
    }
}

// MARK: - Handle Player Inputs
extension ArcadeGameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if squirrel.isInAir == false {
            squirrel.physicsBody?.applyImpulse(CGVector(dx: physicsWorld.gravity.dx < 0 ? 350 : -350, dy: 0))
            squirrel.animateJump()
            physicsWorld.gravity = CGVector(dx: -physicsWorld.gravity.dx, dy: 0)
        }
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
        return gameLogic.isGameOver
    }
    
    func finishGame() {
        gameLogic.isGameOver = true
    }
}


// MARK: - Register Score
extension ArcadeGameScene {
    
    private func registerScore() {
    }
}
