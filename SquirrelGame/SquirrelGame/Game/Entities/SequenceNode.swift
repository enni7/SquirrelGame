//
//  SequenceNode.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 30/03/22.
//

import SpriteKit

class SequenceNode: SKNode {
    var frameShape = SKShapeNode()
    
    init(sequenceNum: Int){
        super.init()
        frameShape = SKShapeNode(rectOf: CGSize(width: 414, height: 896))
        frameShape.fillColor = .clear
        frameShape.lineWidth = 0
        frameShape.position = CGPoint(x: 0, y: -screenSize.height)

        addChild(frameShape)

        addLeftSpine(atY: 100)
        addRightSpine(atY: -100)

        moveUpFrame()
    }
    func addTextureTrees(){
        
    }
    func addRightSpine(atY: CGFloat){
        let spine = SpinesSprite(onRightAt: atY)
        self.frameShape.addChild(spine)
    }
    func addLeftSpine(atY: CGFloat){
        let spine = SpinesSprite(onLeftAt: atY)
        self.frameShape.addChild(spine)
    }

    func moveUpFrame(){
        let moveUp = SKAction.moveBy(x: 0, y: frameShape.frame.size.height * 2, duration: 10)
        self.run(moveUp) {
            self.removeFromParent()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FrameSpawner: SKNode {
    
    func startCreatingObstacles(){
        let spawn = SKAction.run {
            self.createMovingObstacle()
        }
        let wait = SKAction.wait(forDuration: 5)
        let loopSpawn = SKAction.repeatForever(SKAction.sequence([spawn, wait]))
        self.run(loopSpawn)
    }
    
    func createMovingObstacle(){
        let node = SequenceNode(sequenceNum: 1)
        scene?.addChild(node)
    }
}
