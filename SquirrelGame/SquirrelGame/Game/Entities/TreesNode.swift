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
        createMovingGroundAndSky()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createWood(){
        
        leftWood = SKShapeNode(rectOf: CGSize(width: 60, height: screenSize.height))
        leftWood.name = "cLeftWood"
        leftWood.fillColor = .white
        leftWood.fillTexture = SKTexture(imageNamed: "WoodLeft")
        leftWood.lineWidth = 0
        leftWood.position = CGPoint(x: -screenSize.width / 2, y: 0)
        
        leftWood.physicsBody = SKPhysicsBody(rectangleOf: leftWood.frame.size)
        leftWood.physicsBody?.categoryBitMask = PhysicsCategory.cSideWood
        leftWood.physicsBody?.contactTestBitMask = PhysicsCategory.bSquirrel
        leftWood.physicsBody?.collisionBitMask = PhysicsCategory.bSquirrel
        leftWood.physicsBody?.isDynamic = false
        leftWood.physicsBody?.restitution = 0
        
        addChild(leftWood)
        
        rightWood = SKShapeNode(rectOf: CGSize(width: 60, height: screenSize.height))
        rightWood.name = "cRightWood"
        rightWood.fillColor = .white
        rightWood.fillTexture = SKTexture(imageNamed: "WoodRight")
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
    
    func createMovingGroundAndSky() {
        for i in 0 ... 1 {
            let dumbNode = SKNode()
            let newLeftGround = SKShapeNode(rectOf: self.leftWood.frame.size)
            newLeftGround.fillColor = .white
            newLeftGround.fillTexture = SKTexture(imageNamed: "WoodLeft")
            newLeftGround.lineWidth = 0
            newLeftGround.position = CGPoint(x: leftWood.position.x, y: leftWood.position.y - (newLeftGround.frame.height * CGFloat(i)))
            dumbNode.addChild(newLeftGround)
            
            let newRightGround = SKShapeNode(rectOf: self.leftWood.frame.size)
            newRightGround.fillColor = .white
            newRightGround.fillTexture = SKTexture(imageNamed: "WoodRight")
            newRightGround.lineWidth = 0
            newRightGround.position = CGPoint(x: rightWood.position.x, y: rightWood.position.y - (newLeftGround.frame.height * CGFloat(i)))
            dumbNode.addChild(newRightGround)
            
            let bg1 = SKSpriteNode(texture: SKTexture(imageNamed: "background1"))
            bg1.size = screenSize
            bg1.zPosition = -50
            bg1.position = CGPoint(x: 0, y: 0 - (bg1.frame.height * CGFloat(i)))

            dumbNode.addChild(bg1)

            let moveUp = SKAction.moveBy(x: 0, y: newLeftGround.frame.size.height, duration: 5)
            let moveReset = SKAction.moveBy(x: 0, y: -newLeftGround.frame.size.height, duration: 0)
            let moveLoop = SKAction.sequence([moveUp, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            dumbNode.run(moveForever, withKey: "scrolling sky and woods")
            addChild(dumbNode)
        }
    }
}
