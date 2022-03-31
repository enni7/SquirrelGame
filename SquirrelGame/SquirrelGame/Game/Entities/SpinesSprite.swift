//
//  SpinesSprite.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 30/03/22.
//

import SpriteKit

class SpinesSprite: SKSpriteNode {
    init(onLeftAt positionY: CGFloat, numberOfSpines123: Int) {
        let leftTexture = SKTexture(imageNamed: "spines\(numberOfSpines123)left")
        super.init(texture: leftTexture, color: .white, size: CGSize(width: leftTexture.size().width * 1.5, height: leftTexture.size().height * 1.5) )
        self.name = "eSpines"
        self.zPosition = 20
        self.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.position = CGPoint(x: (-screenSize.width / 2) + 26, y: positionY)

        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.categoryBitMask = PhysicsCategory.eSpines
        physicsBody?.contactTestBitMask = PhysicsCategory.bSquirrel
        physicsBody?.collisionBitMask = PhysicsCategory.bSquirrel
        physicsBody?.isDynamic = false
    }
    
    init(onRightAt positionY: CGFloat, numberOfSpines123: Int){
        let rightTexture = SKTexture(imageNamed: "spines\(numberOfSpines123)right")

        super.init(texture: rightTexture, color: .white, size: CGSize(width: rightTexture.size().width * 1.5, height: rightTexture.size().height * 1.5) )
        self.name = "eSpines"
        self.zPosition = 20
        self.anchorPoint = CGPoint(x: 1, y: 0.5)
        self.position = CGPoint(x: (screenSize.width / 2) - 26, y: positionY)

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
