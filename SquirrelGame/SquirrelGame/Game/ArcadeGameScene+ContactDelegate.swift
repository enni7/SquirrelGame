//
//  ArcadeGameScene+ContactDelegate.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import Foundation
import SpriteKit

extension ArcadeGameScene : SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        let sortedNodes = [nodeA, nodeB].sorted {$0.name ?? "" < $1.name ?? ""}
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        if firstNode.physicsBody?.categoryBitMask == PhysicsCategory.bSquirrel {
        if secondNode.name == "cLeftWood" || secondNode.name == "cRightWood" || secondNode.name == "cMiddleWood" {
            if firstNode.name == "bSquirrel" {
                if squirrel.action(forKey: "jumpSquirrel") == nil {
                    if squirrel.isInAir == true {
                        squirrel.isInAir = false
                        squirrel.isJumping = false
                        if physicsWorld.gravity.dx > 0 {
                            squirrel.touchingWoodOnSide = .right
                        } else {
                            squirrel.touchingWoodOnSide = .left
                        }
                        squirrel.animateLanding()
                    }
                }
            }
        }
        if secondNode.name == "dNutNormal" {
            if let nut = secondNode as? GoldenNutSprite {
                nut.animateNormalNutPick()
            }
            
            secondNode.removeFromParent()
            gameLogic.score(points: 1)
            
            self.run(pickUpSound)
        }
        if secondNode.name == "eSpines" || secondNode.name == "gBranch" {
            if squirrel.isAlive == true{
                        squirrel.isAlive = false
                        preFinish()
            }
        }
        if secondNode.name == "dNutGold"{
            if squirrel.isDashing {
                if let nut = secondNode as? GoldenNutSprite {
                    nut.animateBoxBreak()
                }
                secondNode.removeFromParent()
                camera?.run(SKAction.sequence([SKAction.moveBy(x: 0, y: 4, duration: 0.1), SKAction.moveBy(x: 0, y: -4, duration: 0.1)]))
                squirrel.bounceOnOtherSide()
                self.makeHaptic()
                self.run(boxSound)
                gameLogic.score(points: 5)
            }
        }
    }
    }
}

