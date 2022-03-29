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
        
        if secondNode.name == "cLeftWood" || secondNode.name == "cRightWood" || secondNode.name == "cMiddleWood" {
            if firstNode.name == "bSquirrel" {
                if physicsWorld.gravity.dx > 0 {
                    squirrel.touchingWoodOnSide = .right
                } else {
                    squirrel.touchingWoodOnSide = .left
                }
                squirrel.animateLanding()
            }
        }
        if secondNode.name == "dGhianda" {
            gameLogic.score(points: 5)
            self.run(pickUpSound)
        }
        if secondNode.name == "eSpines" {
            squirrel.life -= 1
//            self.run(pickUpSound)
            if squirrel.life == 0 {
                self.finishGame()
            }
        }
        if secondNode.name == "fGoldGhianda"{
            self.run(pickUpSound)
            gameLogic.score(points: 10)
        }
    }
}
