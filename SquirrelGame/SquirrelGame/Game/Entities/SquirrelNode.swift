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
        self.zPosition = 100
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
        
        physicsBody?.contactTestBitMask = PhysicsCategory.cSideWood
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
    
    func animateSquirrelDeath(){
        self.removeAllActions()
//        self.physicsBody = nil
        animateSceneDeath()
        
        let pat = UIBezierPath()
        pat.move(to: self.position)
        pat.addQuadCurve(to: CGPoint(x: 0, y: scene?.frame.minY ?? -444), controlPoint: CGPoint(x: isInAir ? 0 : -self.position.x * 0.5, y: (isInAir ? self.position.y : self.position.y + 150)))
//        let follow = SKAction.follow(pat.cgPath, asOffset: false, orientToPath: false, duration: 0.3)
//        follow.timingMode = .easeOut
//        self.run(follow)
        
        let pat2 = UIBezierPath()
        pat2.move(to: self.position)
        pat2.addQuadCurve(to: CGPoint(x: 0, y: self.position.y + 70), controlPoint: CGPoint(x: self.position.x, y: (self.position.y + 70)))
        let follow2 = SKAction.follow(pat2.cgPath, asOffset: false, orientToPath: false, duration: 0.3)
        follow2.timingMode = .easeOut
//        self.run(follow2)
        physicsBody?.categoryBitMask = PhysicsCategory.iDeadSquirrel

        let impulse = CGVector(dx: touchingWoodOnSide == .left ? 350 : -350, dy: 700)
        self.physicsBody?.applyImpulse(impulse)
        self.run(SKAction.rotate(byAngle: (touchingWoodOnSide == .left ? -.pi*5 : .pi*5) , duration: 0.7))
        
    }
    
    func animateSceneDeath(){
        scene?.speed = 0.2
        scene?.physicsWorld.speed = 0.3
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: -50)
        let shakeCam = SKAction.sequence([
            SKAction.move(by: CGVector(dx: 0.8, dy: 2), duration: 0.01),
            SKAction.move(to: .zero, duration: 0.01),
            SKAction.move(by: CGVector(dx: -1.5, dy: -0.7), duration: 0.01),
            SKAction.move(to: .zero, duration: 0.01),
            SKAction.move(by: CGVector(dx: 1.5, dy: 0.6), duration: 0.01),
            SKAction.move(to: .zero, duration: 0.01),
        ])
        scene?.camera?.run(SKAction.repeat(shakeCam, count: 2))
    }
                            
    enum TouchingWoodOnSide {
        case left, right
    }
}
