//
//  SquirrelNode.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import SpriteKit

class SquirrelNode: SKSpriteNode {
    private var runningFramesOnLeft: [SKTexture] = []
    private var runningFramesOnRight: [SKTexture] = []
    private var firstTexture: SKTexture!
    private var jumpTextureFromLeft: SKTexture!
    private var jumpTextureFromRight: SKTexture!
    private var ballTexture = SKTexture(imageNamed: "squirrelball 1 3")
    private var dashTexture = SKTexture(imageNamed: "dash2")

    var isInAir: Bool = false
    var isDashing: Bool = false
    var touchingWoodOnSide: TouchingWoodOnSide!
    var isAlive = true
    var startingX: CGFloat!
    
    init(at position: CGPoint) {
        touchingWoodOnSide = .left
        
        let squirrelAnimatedAtlas = SKTextureAtlas(named: "squirrelRunning1")
        var runFrames: [SKTexture] = []
        
        let numImages = squirrelAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let squirrelTextureName = "squirrelRunning1\(i)@3x"
            runFrames.append(squirrelAnimatedAtlas.textureNamed(squirrelTextureName))
        }
        self.runningFramesOnLeft = runFrames
        
        self.firstTexture = runningFramesOnLeft[0]
        self.jumpTextureFromLeft = runningFramesOnLeft[1]
        
        let squirrelAnimatedAtlas2 = SKTextureAtlas(named: "squirrelRunning2")
        var runFrames2: [SKTexture] = []
        
        let numImages2 = squirrelAnimatedAtlas2.textureNames.count
        for i in 1...numImages2 {
            let squirrelTextureName2 = "squirrelRunning2\(i)@3x"
            runFrames2.append(squirrelAnimatedAtlas2.textureNamed(squirrelTextureName2))
        }
        self.runningFramesOnRight = runFrames2
        self.jumpTextureFromRight = runningFramesOnRight[1]
        
        super.init(texture: firstTexture, color: .white, size: CGSize(width: firstTexture.size().width * 2, height: firstTexture.size().height * 2))
        self.zPosition = 50
        self.position = position
        self.name = "bSquirrel"
        
        self.startingX = position.x

        physicsBody = SKPhysicsBody(texture: firstTexture, size: CGSize(width: self.size.width * 0.95, height: self.size.height * 0.95))
        setUpPhysicBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPhysicBody(){
        physicsBody?.affectedByGravity = true
        physicsBody?.restitution = 0
        physicsBody?.mass = 1
        physicsBody?.allowsRotation = false
        
        physicsBody?.categoryBitMask = PhysicsCategory.bSquirrel
        
        physicsBody?.contactTestBitMask = PhysicsCategory.cSideWood | PhysicsCategory.dGhianda
        physicsBody?.collisionBitMask = PhysicsCategory.cSideWood
    }
    
    func animateRun() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: self.touchingWoodOnSide == .left ? runningFramesOnLeft : runningFramesOnRight,
                             timePerFrame: 0.15,
                             resize: false,
                             restore: false)),
                 withKey: "runningSquirrel")
    }
    func animateDashingDown() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: [ballTexture],
                             timePerFrame: 0.15,
                             resize: false,
                             restore: false)),
                 withKey: "dashingAnimation")
        self.run(SKAction.rotate(toAngle: 0, duration: 0.1, shortestUnitArc: true))
    }

    func jump(){
        if self.isInAir == false && self.isDashing == false {
            self.physicsBody?.applyImpulse(CGVector(dx: touchingWoodOnSide == .left ? 350 : -350, dy: 0))
            self.animateJump()
        }
    }
    func animateJump(){
        self.removeAction(forKey: "runningSquirrel")
        self.texture = jumpTextureFromLeft
        self.run(SKAction.rotate(toAngle: touchingWoodOnSide == .left ? .pi/6 : -.pi/6, duration: 0.1, shortestUnitArc: true)){
            self.isInAir = true
        }
    }
    
    func land(){
        
    }
    func animateLanding(){
            self.isDashing = false
            self.animateRun()
            self.physicsBody?.affectedByGravity = true
//        self.run(SKAction.scaleX(to: abs(self.xScale) * (touchingWoodOnSide == .left ? 1 : -1), duration: 0.05))
        self.run(SKAction.rotate(toAngle: 0, duration: 0.05, shortestUnitArc: true))
        guard let sceneCamera = scene?.camera else {return}
        let moveLeft = SKAction.moveBy(x: -1, y: 0, duration: 0.1)
        let moveRight = SKAction.moveBy(x: 1, y: 0, duration: 0.1)
        let seqLeft = SKAction.sequence([moveLeft, moveRight])
        let seqRight = SKAction.sequence([moveRight, moveLeft])
        sceneCamera.run(touchingWoodOnSide == .left ? seqRight : seqLeft)
    }
    
    func dashDown(){
        if self.isInAir && self.isDashing == false {
            self.isDashing = true
            self.removeAction(forKey: "restoreY")
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.velocity = CGVector(dx: 0, dy: -700)
            self.animateDownDash()
        }
    }
    func animateDownDash(){
        self.run(SKAction.setTexture(ballTexture))
        self.run(SKAction.rotate(toAngle: 0, duration: 0.1, shortestUnitArc: true))
    }
    
    func bounceOnOtherSide(){
        self.physicsBody?.affectedByGravity = true
        let impulse = CGVector(dx: touchingWoodOnSide == .left ? 100 : -100, dy: 800)
        self.physicsBody?.applyImpulse(impulse)
        self.animateUpBounce()
        restoreYPosition()
    }
    func animateUpBounce(){
        self.run(SKAction.rotate(toAngle: touchingWoodOnSide == .left ? .pi/1.6 : -.pi/1.6, duration: 0.1, shortestUnitArc: true))
    }

    func restoreYPosition(){
        let action = SKAction.moveTo(y: 200, duration: 2.7)
        self.run(action, withKey: "restoreY")
    }
                            
    enum TouchingWoodOnSide {
        case left, right
    }
}
