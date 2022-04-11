//
//  ArcadeGameScene+inputs.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 01/04/22.
//

import SpriteKit

// MARK: - Handle Player Inputs
extension ArcadeGameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if squirrel.isInAir == false && squirrel.isJumping == false {
            self.run(jumpSound)
            squirrel.jump()
        } else if squirrel.action(forKey: "landingSequence") == nil  {
            squirrel.dashDown()
        }
    }
}
