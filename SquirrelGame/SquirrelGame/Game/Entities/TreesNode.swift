//
//  TreesNode.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import SpriteKit

extension SKNode {
    var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
}

class TreesNode: SKNode {
    
    var leftWood: SKShapeNode!
    var rightWood: SKShapeNode!
    
    override init() {
        super.init()
        createWood()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createWood(){
        
        leftWood = SKShapeNode(rectOf: CGSize(width: 60, height: screenSize.height * 1.5))
        leftWood.name = "cLeftWood"
        leftWood.fillColor = .brown
        leftWood.lineWidth = 0
        leftWood.position = CGPoint(x: -screenSize.width / 2, y: 0)
        
        leftWood.physicsBody = SKPhysicsBody(rectangleOf: leftWood.frame.size)
        leftWood.physicsBody?.categoryBitMask = PhysicsCategory.cSideWood
        leftWood.physicsBody?.contactTestBitMask = PhysicsCategory.bSquirrel
        leftWood.physicsBody?.collisionBitMask = PhysicsCategory.bSquirrel
        leftWood.physicsBody?.isDynamic = false
        leftWood.physicsBody?.restitution = 0
        
        let redDot = SKShapeNode(rectOf: CGSize(width: leftWood.frame.size.width, height: 70))
        redDot.fillColor = .red
        redDot.position = CGPoint(x: 0, y: 100)
        leftWood.addChild(redDot)
        addChild(leftWood)
        
        rightWood = SKShapeNode(rectOf: CGSize(width: 60, height: screenSize.height * 1.5))
        rightWood.name = "cRightWood"
        rightWood.fillColor = .brown
        rightWood.lineWidth = 0
        rightWood.position = CGPoint(x: screenSize.width / 2, y: 0)
        rightWood.physicsBody = SKPhysicsBody(rectangleOf: leftWood.frame.size)
        rightWood.physicsBody?.categoryBitMask = PhysicsCategory.cSideWood
        rightWood.physicsBody?.contactTestBitMask = PhysicsCategory.bSquirrel
        rightWood.physicsBody?.collisionBitMask = PhysicsCategory.bSquirrel
        rightWood.physicsBody?.isDynamic = false
        rightWood.physicsBody?.restitution = 0
        addChild(rightWood)
        
    }
    
    func createMiddleWood(){
        rightWood = SKShapeNode(rectOf: CGSize(width: 60, height: screenSize.height * 1.5))
        rightWood.name = "cRightWood"
        rightWood.fillColor = .brown
        rightWood.lineWidth = 0
        rightWood.position = CGPoint(x: screenSize.width / 2, y: 0)
        rightWood.physicsBody = SKPhysicsBody(rectangleOf: leftWood.frame.size)
        rightWood.physicsBody?.categoryBitMask = PhysicsCategory.cSideWood
        rightWood.physicsBody?.contactTestBitMask = PhysicsCategory.bSquirrel
        rightWood.physicsBody?.collisionBitMask = PhysicsCategory.bSquirrel
        rightWood.physicsBody?.isDynamic = false
        rightWood.physicsBody?.restitution = 0

    }

}
