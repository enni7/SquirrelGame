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
    let boxBreakTexture = SKTexture(imageNamed: "box-hit 1")
    let nutPickTexture = SKTexture(imageNamed: "nut-hit 1")

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
    
    func animateBoxBreak(){
        animateNutPick()
        if let particle = SKEmitterNode(fileNamed: "MyParticle"){
            particle.name = "particle"
            particle.position = self.position
            parent?.addChild(particle)
            particle.run(SKAction.wait(forDuration: 7)){
                particle.removeFromParent()
            }
        }
    }
    func animateNutPick(){
        let boxTexture = boxBreakTexture
        let goldBox = SKSpriteNode(texture: boxTexture, color: .white, size: self.size)
        goldBox.position = self.position
        goldBox.zPosition = self.zPosition
    
        let animAlpha = SKAction.fadeAlpha(to: 0, duration: 0.1)
        let animAlpha2 = SKAction.fadeAlpha(to: 1, duration: 0.1)
        let seq = SKAction.sequence([animAlpha2, animAlpha])
        goldBox.run(SKAction.repeat(seq, count: 4))
        
        parent?.addChild(goldBox)
    }
    func animateNormalNutPick(){
        let nutText = nutPickTexture
        let nutPick = SKSpriteNode(texture: nutTexture2, color: .white, size: self.size)
        nutPick.position = self.position
        nutPick.zPosition = self.zPosition
        
        let flip1 = SKAction.scaleX(to: -1, duration: 0.2)
        let flip2 = SKAction.scaleX(to: 1, duration: 0.2)
        let flipSeq = SKAction.sequence([flip1, flip2])
        
        let changeText = SKAction.setTexture(nutText)
        let fade = SKAction.fadeAlpha(to: 0, duration: 0.2)
        let seq2 = SKAction.sequence([changeText, fade])
        
        nutPick.run(SKAction.sequence([flipSeq, seq2]))
        parent?.addChild(nutPick)
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
