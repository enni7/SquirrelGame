//
//  PhysicsCategory.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import Foundation

struct PhysicsCategory {
    static let zNone : UInt32 = 0
    static let all : UInt32 = UInt32.max
    static let bSquirrel : UInt32 = 0b1
    static let cSideWood : UInt32 = 0b10
    static let dGhianda: UInt32 = 0b100
    static let eSpines: UInt32 = 0b1000
    static let gBranch: UInt32 = 0b10000
    static let hParticle: UInt32 = 0b100000
    static let iDeadSquirrel : UInt32 = 0b1000000

}
