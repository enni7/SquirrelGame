//
//  ArcadeGameScene+inputs.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 01/04/22.
//

import SpriteKit

// MARK: - Handle Player Inputs
extension ArcadeGameScene {
    func pauseTry(){
        for child in self.children {
            if child.name != "particle" && child.name != "bSquirrel"{
            child.isPaused = true
            }
        }
    }
    func resumeTry(){
        for child in self.children {
            child.isPaused = false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if squirrel.isInAir == false {
            self.run(jumpSound)
            squirrel.jump()
            physicsWorld.gravity = CGVector(dx: -physicsWorld.gravity.dx, dy: 0)
        } else {
            squirrel.dashDown()
        }
    }
    
    func setUpSwipeDownGesture(){
        let swipeDown = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(self.swipeDown(sender:)))
        swipeDown.direction = .down
        view?.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeDown(sender: UISwipeGestureRecognizer) {
//        squirrel.dashDown()
    }
}
