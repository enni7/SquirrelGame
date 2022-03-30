//
//  SpinesSprite.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 30/03/22.
//

import SpriteKit

class SpinesSprite: SKSpriteNode {
    let leftTexture = SKTexture(imageNamed: "thorn_left")
    let rightTexture = SKTexture(imageNamed: "thorn_right")

    init(at position: CGPoint) {
        super.init(texture: leftTexture, color: .white, size: CGSize(width: leftTexture.size().width * 1.5, height: leftTexture.size().height * 1.5) )
        self.name = "eSpines"
        self.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.position = position

        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.categoryBitMask = PhysicsCategory.eSpines
        physicsBody?.contactTestBitMask = PhysicsCategory.bSquirrel
        physicsBody?.collisionBitMask = PhysicsCategory.bSquirrel
        physicsBody?.isDynamic = false

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
