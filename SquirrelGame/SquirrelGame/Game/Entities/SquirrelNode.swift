//
//  SquirrelNode.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import SpriteKit

class SquirrelNode: SKSpriteNode {
    private var runningFramesOnLeft: [SKTexture] = []
    private var firstTexture: SKTexture!
    private var jumpTextureFromLeft: SKTexture!
    
    var isInAir: Bool = false
    var isDashing: Bool = false
    var touchingWoodOnSide: TouchingWoodOnSide!
    
    init(at position: CGPoint) {
        touchingWoodOnSide = .left
        
        let squirrelAnimatedAtlas = SKTextureAtlas(named: "squirrelRunning")
        var runFrames: [SKTexture] = []
        
        let numImages = squirrelAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let squirrelTextureName = "squirrelRunning\(i)@3x"
            runFrames.append(squirrelAnimatedAtlas.textureNamed(squirrelTextureName))
        }
        self.runningFramesOnLeft = runFrames
        
        self.firstTexture = runningFramesOnLeft[0]
        self.jumpTextureFromLeft = runningFramesOnLeft[1]
        
        super.init(texture: firstTexture, color: .white, size: CGSize(width: firstTexture.size().width * 2, height: firstTexture.size().height * 2))
        self.zPosition = 50
        self.position = position
        self.name = "bSquirrel"
//
//        let constrain = SKConstraint.positionY(SKRange(constantValue: position.y))
//        self.constraints = [constrain]
        
        physicsBody = SKPhysicsBody(texture: firstTexture, size: CGSize(width: self.size.width * 0.96, height: self.size.height * 0.96))
        physicsBody?.affectedByGravity = true
        physicsBody?.restitution = 0
        physicsBody?.mass = 1
        physicsBody?.allowsRotation = false
        
        physicsBody?.categoryBitMask = PhysicsCategory.bSquirrel
        
        physicsBody?.contactTestBitMask = PhysicsCategory.cSideWood | PhysicsCategory.dGhianda
        physicsBody?.collisionBitMask = PhysicsCategory.cSideWood
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func jump(){
        if self.isInAir == false && self.isDashing == false {
            self.physicsBody?.applyImpulse(CGVector(dx: touchingWoodOnSide == .left ? 350 : -350, dy: 0))
            self.animateJump()
        }
    }
    
    func dashDown(){
        if self.isInAir && self.isDashing == false {
            self.isDashing = true
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.velocity = CGVector(dx: 0, dy: -700)
            self.animateDownDash()
            
//            let move = SKAction.moveBy(x: 0, y: -700, duration: 1)
//            self.run(move, withKey: "dashMove")
        }
    }
    func restoreWalk(){
        self.physicsBody?.affectedByGravity = true
    }
    
    func bounceOnOtherSide(){
        self.physicsBody?.affectedByGravity = true
        let impulse = CGVector(dx: touchingWoodOnSide == .left ? 100 : -100, dy: 800)
        self.physicsBody?.applyImpulse(impulse)
        self.animateUpBounce()
        restoreYPosition()
    }
    
    func dashToRight(){
        if self.isInAir && self.isDashing == false {
            self.isDashing = true
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.velocity = CGVector(dx: touchingWoodOnSide == .left ? 1000 : -1000, dy: 0)
            self.animateHorizontalDash()
        }
    }
    
    func restoreYPosition(){
        let action = SKAction.moveTo(y: 200, duration: 2.5)
        self.run(action)
    }
        
    func animateRun() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: runningFramesOnLeft,
                             timePerFrame: 0.15,
                             resize: false,
                             restore: false)),
                 withKey: "runningSquirrel")
    }
    
    func animateUpBounce(){
        self.run(SKAction.rotate(toAngle: touchingWoodOnSide == .left ? .pi/1.6 : -.pi/1.6, duration: 0.1, shortestUnitArc: true))
    }
    func animateDownDash(){
        self.run(SKAction.rotate(toAngle: 0, duration: 0.1, shortestUnitArc: true))
    }
    
    func animateHorizontalDash(){
        self.run(SKAction.rotate(toAngle: touchingWoodOnSide == .left ? .pi/2 : -.pi/2, duration: 0.1, shortestUnitArc: true))
    }
    
    func animateJump(){
        self.removeAction(forKey: "runningSquirrel")
        self.texture = jumpTextureFromLeft
        self.run(SKAction.rotate(toAngle: touchingWoodOnSide == .left ? .pi/6 : -.pi/6, duration: 0.1, shortestUnitArc: true)){
            self.isInAir = true
        }
    }
    func animateLanding(){
        self.run(SKAction.setTexture(firstTexture)){
            self.isInAir = false
            self.isDashing = false
            self.animateRun()
            self.physicsBody?.affectedByGravity = true
        }
        self.run(SKAction.scaleX(to: abs(self.xScale) * (touchingWoodOnSide == .left ? 1 : -1), duration: 0.05))
        self.run(SKAction.rotate(toAngle: 0, duration: 0.05, shortestUnitArc: true))
    }
    
    enum TouchingWoodOnSide {
        case left, right
    }
}
