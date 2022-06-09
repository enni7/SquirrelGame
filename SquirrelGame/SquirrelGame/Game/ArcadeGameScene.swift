//
//  ArcadeGameScene.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import AVFoundation
import SpriteKit
import SwiftUI


class ArcadeGameScene: SKScene, ObservableObject {
    // The Game Logic that keeps track of the game variables
    var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared
    // Keeps track of when the last update happend.
    var lastUpdate: TimeInterval = 0
    var timeSinceLastUpdate : Int = 0
        
    //Responsable of spawning frames and side trees
    let frameSpawner = FrameSpawner()
    var treeNode: TreesNode!
    
    var squirrel: SquirrelNode!
    
    //    var scaleFactor: CGFloat!
    let notificationCenter = NotificationCenter.default
    
    let pickUpSound = SKAction.playSoundFileNamed(SoundFile.pickUpSound, waitForCompletion: false)
    let jumpSound = SKAction.playSoundFileNamed(SoundFile.jump, waitForCompletion: false)
    let boxSound = SKAction.playSoundFileNamed(SoundFile.boxNut, waitForCompletion: false)
    let gameOverSound = SKAction.playSoundFileNamed(SoundFile.gameOver, waitForCompletion: true)
    
    override func didMove(to view: SKView) {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: nil)

        self.setUpGame()
        self.setUpPhysicsWorld()
        self.setUpCamera()
        self.frameSpawner.startLoopingFramesCreation()
        self.inscreseSpeedAction()
//
//        let wait = SKAction.wait(forDuration: 5)
//        let seq = SKAction.sequence([wait, SKAction.run {
//            print(self.children.count)
//        }])
//        self.run(SKAction.repeatForever(seq))
    }
    @objc func applicationWillResignActive(notification: NSNotification) {
        self.isPaused = true
    }

    override func update(_ currentTime: TimeInterval) {
        
        if self.speed > 3 {
            self.removeAction(forKey: "increseSpeed")
        }

        // If the game over condition is met, the game will finish
        playerOutOnBottom()
        squirrel.setUpXScale()
        
        // The first time the update function is called we must initialize the
        // lastUpdate variable
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        // Calculates how much time has passed since the last update
        //        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        //        // Increments the length of the game session at the game logic
        //        self.gameLogic.increaseSessionTime(by: timeElapsedSinceLastUpdate)
        
        self.lastUpdate = currentTime
    }
}

//MARK: - Increse Speed
extension ArcadeGameScene {
    func inscreseSpeedAction() {
        let wait = SKAction.wait(forDuration: 7)
        let increse = SKAction.run {
            self.speed = self.speed * 1.05
            self.physicsWorld.speed = self.physicsWorld.speed * 1.02
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
        createScrollingFrames()
        createPlayer()
    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: -10, dy: 0)
        physicsWorld.contactDelegate = self
        physicsWorld.speed = 1
    }
    private func setUpCamera() {
        let cameraNode = SKCameraNode()
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        cameraNode.position = .zero
        cameraNode.name = "camera"
    }
    
    
    //    private func restartGame() {
    //        self.gameLogic.restartGame()
    //    }
    func pauseTry(){
        for child in self.children {
            child.isPaused = true
        }
    }
    func resumeTry(){
        for child in self.children {
            child.isPaused = false
        }
    }

    @objc func pauseGame() {
        pauseTry()
    }
    @objc func resumeGame() {
        resumeTry()
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
        self.squirrel.animateRun()
        
        addChild(self.squirrel)
    }
}

// MARK: - Create scrolling frames
extension ArcadeGameScene {
    func createScrollingFrames(){
        addChild(frameSpawner)
        treeNode = TreesNode()
        addChild(treeNode)
    }
}

// MARK: - Game Over Condition
extension ArcadeGameScene {
    func playerOutOnBottom(){
        if squirrel.isAlive{
            if squirrel.frame.minY < self.frame.minY {
                squirrel.isAlive = false
                preFinish()
            }
        }
    }
    var playerIsOutOnBottom: Bool {
        if squirrel.frame.minY < self.frame.minY {
            return true} else {return false}
    }
    
    func preFinish(){
        makeHaptic()
        self.run(gameOverSound)
        self.pauseTry()
        self.gameLogic.finalScore = self.gameLogic.currentScore
        if gameLogic.isBestScore() {
            gameLogic.updateBestScore()
        }
        self.finishGame()
    }
    
    var isGameOver: Bool {
        return gameLogic.isGameOver
    }
    
    func finishGame() {
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
