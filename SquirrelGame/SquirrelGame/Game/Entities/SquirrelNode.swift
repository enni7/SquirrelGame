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
    var touchingWoodOnSide: TouchingWoodOnSide!
    var life: Int = 2
    
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
        
        super.init(texture: firstTexture, color: .white, size: CGSize(width: firstTexture.size().width * 3.2, height: firstTexture.size().height * 3.2))
        self.life = 2
        self.position = position
        self.name = "bSquirrel"
        
        physicsBody = SKPhysicsBody(texture: firstTexture, size: CGSize(width: self.size.width * 0.95, height: self.size.height * 0.95))
        physicsBody?.affectedByGravity = true
        physicsBody?.restitution = 0
        physicsBody?.mass = 1
        physicsBody?.allowsRotation = false
        
        physicsBody?.categoryBitMask = PhysicsCategory.bSquirrel
        
        physicsBody?.contactTestBitMask = PhysicsCategory.cSideWood
        physicsBody?.collisionBitMask = PhysicsCategory.cSideWood
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func animateRun() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: runningFramesOnLeft,
                             timePerFrame: 0.15,
                             resize: false,
                             restore: true)),
                 withKey: "runningSquirrel")
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
            self.animateRun()
        }
        self.run(SKAction.scaleX(to: abs(self.xScale) * (touchingWoodOnSide == .left ? 1 : -1), duration: 0.05))
        self.run(SKAction.rotate(toAngle: 0, duration: 0.05, shortestUnitArc: true))
    }
    
    enum TouchingWoodOnSide {
        case left, right
    }
}
