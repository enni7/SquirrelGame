//
//  SequenceNode.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 30/03/22.
//

import SpriteKit

class SequenceNode: SKNode {
    var frameShape = SKShapeNode()
    
    init(frame: Frame){
        super.init()
        frameShape = SKShapeNode(rectOf: CGSize(width: 414, height: 896))
        frameShape.fillColor = .clear
        frameShape.lineWidth = 2
        frameShape.position = CGPoint(x: 0, y: -screenSize.height)

        addChild(frameShape)
        
        for leftSpineY in frame.leftSpinesPositionsArray {
            addLeftSpine(atY: leftSpineY)
        }
        for rightSpineY in frame.rightSpinesPositionsArray{
            addRightSpine(atY: rightSpineY)
        }
        for leftBrunchY in frame.leftBrunchesYArray{
            createLeftBrunch(at: leftBrunchY)
        }
        for rightBrunchY in frame.rightBrunchesYArray {
            createRightBrunch(at: rightBrunchY)
        }
        for nutPoint in frame.normalNutsPositionsArray{
            createNormalNut(at: nutPoint)
        }
        for nutBoxPoint in frame.boxNutPositionsArray{
            createBoxNut(at: nutBoxPoint)
        }
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
    
    func createMiddleWood(with height: CGFloat, at positionY: CGFloat){
        let middleWood = SKShapeNode(rectOf: CGSize(width: 10, height: height))
        middleWood.name = "cMiddleWood"
        middleWood.zPosition = 10
        middleWood.fillColor = .white
        middleWood.fillTexture = SKTexture(imageNamed: "WoodLeft")
        middleWood.position = CGPoint(x: 0, y: positionY)
        
        middleWood.physicsBody = SKPhysicsBody(rectangleOf: middleWood.frame.size)
        middleWood.physicsBody?.categoryBitMask = PhysicsCategory.cSideWood
        middleWood.physicsBody?.contactTestBitMask = PhysicsCategory.bSquirrel
        middleWood.physicsBody?.collisionBitMask = PhysicsCategory.bSquirrel
        middleWood.physicsBody?.restitution = 0
        middleWood.physicsBody?.isDynamic = false
        self.frameShape.addChild(middleWood)
    }
    
    func createLeftBrunch(at positionY: CGFloat){
        let leftBrunchTexture = SKTexture(imageNamed: "branch_left")
        
        let brunch = SKSpriteNode(texture: leftBrunchTexture, color: .white, size: CGSize(width: leftBrunchTexture.size().width * 2, height: leftBrunchTexture.size().height * 2))
        brunch.name = "gBrunch"
        brunch.zPosition = 20
        brunch.anchorPoint = CGPoint(x: 0, y: 0.5)
        brunch.position = CGPoint(x: (-screenSize.width / 2) + 28, y: positionY)
        self.frameShape.addChild(brunch)

    }
    
    func createRightBrunch(at positionY: CGFloat){
        let rightBrunchTexture = SKTexture(imageNamed: "branch_right")

        let brunch = SKSpriteNode(texture: rightBrunchTexture, color: .white, size: CGSize(width: rightBrunchTexture.size().width * 2, height: rightBrunchTexture.size().height * 2))
        brunch.name = "gBrunch"
        brunch.zPosition = 20
        brunch.anchorPoint = CGPoint(x: 1, y: 0.5)
        brunch.position = CGPoint(x: (screenSize.width / 2) - 28, y: positionY)
        self.frameShape.addChild(brunch)
    }
    
    func createNormalNut(at position: CGPoint) {
        let nut = GoldenNutSprite(nutType: .normal, at: position)
        self.frameShape.addChild(nut)
    }
    func createBoxNut(at position: CGPoint){
        let nut = GoldenNutSprite(nutType: .gold, at: position)
        self.frameShape.addChild(nut)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FrameSpawner: SKNode {
    var frames = [Frame]()
    
    override init() {
        super.init()
        self.populateFramesArray()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateFramesArray(){
        frames.append(Frame.init(leftSpinesPositionsArray: [300],
                                 rightSpinesPositionsArray: [-50],
                                 leftBrunchesYArray: [-200],
                                 rightBrunchesYArray: [80],
                                 normalNutsPositionsArray: [CGPoint.zero],
                                 boxNutPositionsArray: [] ))
        
        frames.append(Frame.init(leftSpinesPositionsArray: [],
                                 rightSpinesPositionsArray: [200],
                                 leftBrunchesYArray: [80],
                                 rightBrunchesYArray: [-80],
                                 normalNutsPositionsArray: [CGPoint.zero],
                                 boxNutPositionsArray: [] ))
        
        frames.append(Frame.init(leftSpinesPositionsArray: [20],
                                 rightSpinesPositionsArray: [300],
                                 leftBrunchesYArray: [-200],
                                 rightBrunchesYArray: [],
                                 normalNutsPositionsArray: [CGPoint.zero],
                                 boxNutPositionsArray: [] ))
    }
    
    func startCreatingObstacles(){
        let spawn = SKAction.run {
            self.createMovingObstacle()
        }
        let wait = SKAction.wait(forDuration: 5)
        let loopSpawn = SKAction.repeatForever(SKAction.sequence([spawn, wait]))
        self.run(loopSpawn)
    }
    
    func createMovingObstacle(){
        let node = SequenceNode(frame: self.frames.randomElement()!)
        scene?.addChild(node)
    }
}


struct Frame {
    var leftSpinesPositionsArray : [CGFloat]
    var rightSpinesPositionsArray : [CGFloat]
    var leftBrunchesYArray : [CGFloat]
    var rightBrunchesYArray : [CGFloat]
    var normalNutsPositionsArray : [CGPoint]
    var boxNutPositionsArray : [CGPoint]
}
