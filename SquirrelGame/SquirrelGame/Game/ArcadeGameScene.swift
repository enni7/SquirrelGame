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
    let jumpSound = SKAction.playSoundFileNamed(SoundFile.jump, waitForCompletion: false)
    let gameOverSound = SKAction.playSoundFileNamed(SoundFile.gameOver, waitForCompletion: true)

    var backgroundMusicAV : AVAudioPlayer!
    var timeSinceLastUpdate : Int = 0
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        self.setUpPhysicsWorld()
        self.frameSpawner.startCreatingObstacles()
        self.inscreseSpeedAction()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if self.speed > 3 {
            self.removeAction(forKey: "increseSpeed")
        }
        // If the game over condition is met, the game will finish
        playerOutOnBottom()
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

//MARK: - Increse Speed
extension ArcadeGameScene {
    func inscreseSpeedAction() {
        let wait = SKAction.wait(forDuration: 7)
        let increse = SKAction.run {
            self.speed = self.speed * 1.1
        }
        let seq = SKAction.sequence([wait, increse])
        let infiniteIncrese = SKAction.repeatForever(seq)
        self.run(infiniteIncrese, withKey: "increseSpeed")
    }
    func increseSpeed(){
        self.physicsWorld.speed = self.physicsWorld.speed * 1.01
    }
}

// MARK: - Game Scene Set Up
extension ArcadeGameScene {
    
    private func setUpGame() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        self.gameLogic.setUpGame()
        setUpMusic()
        self.setUpSwipeDownGesture()
        addChild(frameSpawner)
        createWood()
        createPlayer()
        startRunning()
    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: -10, dy: 0)
        physicsWorld.contactDelegate = self
        physicsWorld.speed = 1
        
    }
    
    private func setUpMusic(){
        if let sound = Bundle.main.path(forResource: "PixelLoop", ofType: "m4a") {
        self.backgroundMusicAV = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            backgroundMusicAV.numberOfLoops = -1
        backgroundMusicAV.play()
        }
    }
    private func startRunning() {
        self.squirrel.animateRun()
    }
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
    private func setUpCamera(){
        let cam = SKCameraNode()
        self.camera = cam
        self.camera!.name = "camera"
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

// MARK: - Create stuff
extension ArcadeGameScene {
    
    func createWood(){
        treeNode = TreesNode()
        addChild(treeNode)
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
    func playerOutOnBottom(){
        if squirrel.frame.minY < self.frame.minY {
            makeHaptic()
            finishGame()
        }
    }
    
    var isGameOver: Bool {
        return gameLogic.isGameOver
    }
    
    func finishGame() {
//        self.run(gameOverSound)
        backgroundMusicAV.stop()
            self.gameLogic.finalScore = self.gameLogic.currentScore
            self.gameLogic.isGameOver = true
    }
}


// MARK: - Vibration
extension ArcadeGameScene {
    
    func makeHaptic() {
        let vibration = SKAction.run {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        self.run(vibration)
    }
}
