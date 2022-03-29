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
        
        if firstNode.name == "bSquirrel" {
            if secondNode.name == "cLeftWood" {
                
                squirrel.touchingWoodOnSide = .left
                squirrel.animateLanding()
            } else if secondNode.name == "cRightWood" {
                squirrel.touchingWoodOnSide = .right
                squirrel.animateLanding()
            }
        }
    }
}
