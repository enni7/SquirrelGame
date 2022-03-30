//
//  GoldenNutSprite.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 30/03/22.
//

import SpriteKit
import SwiftUI

class GoldenNutSprite: SKSpriteNode {
    
    init(nutType: NutType){
        let nutTexture = SKTexture(imageNamed: nutType == .normal ? "nut_1" : "nut_2")

        super.init(texture: nutTexture, color: .white, size: nutTexture.size())
        self.name = nutType == .normal ? "dGhiandaNormal" : "dGhiandaGold"

        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.categoryBitMask = PhysicsCategory.dGhianda
        physicsBody?.contactTestBitMask = PhysicsCategory.bSquirrel
        physicsBody?.collisionBitMask = PhysicsCategory.zNone
        physicsBody?.isDynamic = false

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum NutType {
    case normal, gold
}
