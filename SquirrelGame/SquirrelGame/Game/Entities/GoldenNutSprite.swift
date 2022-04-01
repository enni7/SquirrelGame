//
//  GoldenNutSprite.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 30/03/22.
//

import SpriteKit
import SwiftUI

class GoldenNutSprite: SKSpriteNode {
    let nutTexture1 = SKTexture(imageNamed: "nut_1")
    let nutTexture2 = SKTexture(imageNamed: "nut_2")
    let boxTexture = SKTexture(imageNamed: "nutBox 1")
    let boxBreakTexture = SKTexture(imageNamed: "BrokenBox 1")

    init(nutType: NutType, at position: CGPoint){
        let nutTexture = nutType == .normal ? nutTexture1 : boxTexture

        super.init(texture: nutTexture, color: .white, size: nutTexture.size())
        self.name = (nutType == .normal ? "dNutNormal" : "dNutGold")
        self.position = position

        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.categoryBitMask = PhysicsCategory.dGhianda
        physicsBody?.contactTestBitMask = PhysicsCategory.bSquirrel

        if nutType == .normal {
            physicsBody?.collisionBitMask = PhysicsCategory.bSquirrel
        } else {
            physicsBody?.collisionBitMask = PhysicsCategory.bSquirrel
            physicsBody?.restitution = 1
        }
        physicsBody?.isDynamic = false
        
        if nutType == .normal {
            animNormalNut()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func animBrokenBoxAndRemove(){
        let action = SKAction.setTexture(boxBreakTexture, resize: false)
        self.run(action){
            self.removeFromParent()
        }
    }
    
    func animateBoxBreake(at point: CGPoint){
        if let particle = SKEmitterNode(fileNamed: "MyParticle"){
            particle.name = "particle"
            particle.position = point
            particle.physicsBody = SKPhysicsBody(rectangleOf: particle.particleSize)
            particle.physicsBody?.categoryBitMask = PhysicsCategory.hParticle
            particle.physicsBody?.contactTestBitMask = PhysicsCategory.cSideWood
            particle.physicsBody?.collisionBitMask = PhysicsCategory.cSideWood
            particle.physicsBody?.affectedByGravity = false
            scene?.addChild(particle)
            particle.run(SKAction.wait(forDuration: 7)){
                particle.removeFromParent()
            }
        }
    }

    
    func animNormalNut(){
        let animation = SKAction.animate(with: [nutTexture1, nutTexture2],
                                         timePerFrame: 0.2,
                                         resize: false,
                                         restore: false)
        let loop = SKAction.repeatForever(animation)
        self.run(loop, withKey: "nutAnimation")
    }
}

enum NutXPosition {
    case left, middle, right
}

enum NutType {
    case normal, gold
}
