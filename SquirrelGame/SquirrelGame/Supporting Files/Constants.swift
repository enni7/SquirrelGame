//
//  Constants.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import Foundation
import SwiftUI

/**
 * # Constants
 *
 * This file gathers contant values that are shared all around the project.
 * Modifying the values of these constants will reflect along the complete interface of the application.
 *
 **/


/**
 * # GameState
 * Defines the different states of the game.
 * Used for supporting the navigation in the project template.
 */

enum GameState {
    case mainScreen
    case playing
    case gameOver
}

typealias Instruction = (icon: String, title: String, description: String)

/**
 * # MainScreenProperties
 *
 * Keeps the information that shows up on the main screen of the game.
 *
 */

struct MainScreenProperties {
    static let gameTitle: String = "RuNut!"
    
    static let gameInstructions: [Instruction] = [
//        (icon: "hand.raised", title: "Instruction 1", description: "Instruction description."),
        (icon: "hand.tap", title: "Tap to jump on the opposite wall", description: "Instruction description."),
        (icon: "hand.tap", title: "While jumping tap to bounce down on top of boxes to break them", description: "Instruction description."),
//        (icon: "hand.tap", title: "Instruction 4", description: "Instruction description."),
//        (icon: "hand.raised", title: "Instruction 5", description: "Instruction description."),
//        (icon: "hands.sparkles", title: "Instruction 6", description: "Instruction description."),
    ]
    
    /**
     * To change the Accent Color of the applciation edit it on the Assets folder.
     */
    
    static let accentColor: Color = Color.accentColor
}

struct Frame {
    var leftSpinesPositionsArray : [(CGFloat, Int)]
    var rightSpinesPositionsArray : [(CGFloat, Int)]
    var leftBrunchesYArray : [CGFloat]
    var rightBrunchesYArray : [CGFloat]
    var normalNutsPositionsArray : [CGPoint]
    var boxNutPositionsArray : [CGPoint]
}

struct FramesDatabase {
    let framesArray = [
        
        //3
//        Frame(leftSpinesPositionsArray:  [(-270, 1)],
//              rightSpinesPositionsArray: [],
//
//              leftBrunchesYArray:        [230],
//              rightBrunchesYArray:       [30, -220],
//
//              normalNutsPositionsArray:  [CGPoint(x: 100, y: 105), CGPoint(x: 0, y: 25), CGPoint(x: -100, y: -220), CGPoint(x: -100, y: 375)],
//              boxNutPositionsArray:      [] ),
        
        //4
//        Frame(leftSpinesPositionsArray:  [(-250, 2)],
//              rightSpinesPositionsArray: [(290, 2), (100, 2)],
//
//              leftBrunchesYArray:        [-20],
//              rightBrunchesYArray:       [],
//
//              normalNutsPositionsArray:  [CGPoint(x: 100, y: 230), CGPoint(x: 100, y: -65), CGPoint(x: 0, y: -375)],
//              boxNutPositionsArray:      [CGPoint(x: 100, y: 120)] ),
        
        //5
//        Frame(leftSpinesPositionsArray:  [],
//              rightSpinesPositionsArray: [(60, 3), (170, 3)],
//
//              leftBrunchesYArray:        [-30, -220],
//              rightBrunchesYArray:       [360, 190,],
//
//              normalNutsPositionsArray:  [CGPoint(x: 100, y: 245),
//                                        CGPoint(x: -100, y: -20), CGPoint(x: -100, y: -130),
//                                          CGPoint(x: 0, y: -20), CGPoint(x: 0, y: -130), CGPoint(x: 0, y: -240),
//                                          CGPoint(x: 100, y: -20), CGPoint(x: 100, y: -130), CGPoint(x: 100, y: -240)],
//              boxNutPositionsArray:      [] ),
        
        //6
        Frame(leftSpinesPositionsArray:  [(230, 1), (-310, 3)],
              rightSpinesPositionsArray: [],
              
              leftBrunchesYArray:        [],
              rightBrunchesYArray:       [-30],
              
              normalNutsPositionsArray:  [CGPoint(x: -100, y: 170), CGPoint(x: 100, y: 170), CGPoint(x: 0, y: -10)],
              boxNutPositionsArray:      [CGPoint(x: -100, y: -390)] ),

        //7
//        Frame(leftSpinesPositionsArray:  [(-20, 1)],
//              rightSpinesPositionsArray: [(300, 3)],
//
//              leftBrunchesYArray:        [200],
//              rightBrunchesYArray:       [200],
//
//              normalNutsPositionsArray:  [CGPoint(x: 100, y: 200), CGPoint(x: 0, y: 0)],
//              boxNutPositionsArray:      [CGPoint(x: 100, y: -390)] ),
        
        //8
        Frame(leftSpinesPositionsArray: [(260, 1)],
              rightSpinesPositionsArray: [],
              
              leftBrunchesYArray: [130],
              rightBrunchesYArray: [-120],
              
              normalNutsPositionsArray: [CGPoint(x: -100, y: 350), CGPoint(x: 100, y: 60), CGPoint(x: 100, y: -290)],
              boxNutPositionsArray: [CGPoint(x: -100, y: -360)]),
                
        //easy mode
        Frame(leftSpinesPositionsArray:  [(300, 1)],
              rightSpinesPositionsArray: [],

              leftBrunchesYArray:        [],
              rightBrunchesYArray:       [-200],

              normalNutsPositionsArray:  [],
              boxNutPositionsArray:      [CGPoint.zero] ),

        Frame(leftSpinesPositionsArray: [],
              rightSpinesPositionsArray: [(250, 1)],
              leftBrunchesYArray: [0],
              rightBrunchesYArray: [-200],
              normalNutsPositionsArray: [],
              boxNutPositionsArray: [CGPoint.zero] ),

        Frame(leftSpinesPositionsArray: [(20, 1)],
              rightSpinesPositionsArray: [(300, 1)],
              leftBrunchesYArray: [-200],
              rightBrunchesYArray: [],
              normalNutsPositionsArray: [CGPoint.zero],
              boxNutPositionsArray: [] ),
        
        //9
        Frame(leftSpinesPositionsArray: [],
              rightSpinesPositionsArray: [(260, 2), (-200, 3)],
              leftBrunchesYArray: [140],
              rightBrunchesYArray: [],
              normalNutsPositionsArray: [CGPoint(x: -100, y: 200)],
              boxNutPositionsArray: [CGPoint(x: 100, y: -110)]),
        //10
        Frame(leftSpinesPositionsArray: [(60, 2)],
              rightSpinesPositionsArray: [(-160, 3)],

              leftBrunchesYArray: [320],
              rightBrunchesYArray: [],

              normalNutsPositionsArray: [CGPoint(x: 0, y: 240), CGPoint(x: 100, y: -40)],
              boxNutPositionsArray: []),

        //11
        Frame(leftSpinesPositionsArray: [(360, 1)],
              rightSpinesPositionsArray: [(-120, 2)],

              leftBrunchesYArray: [-320],
              rightBrunchesYArray: [140],

              normalNutsPositionsArray: [CGPoint(x: -100, y: 280), CGPoint(x: 0, y: 80), CGPoint(x: -100, y: -250), CGPoint(x: 100, y: -400)],
              boxNutPositionsArray: []),

        //12
        Frame(leftSpinesPositionsArray: [],
              rightSpinesPositionsArray: [(340, 1), (60, 3)],

              leftBrunchesYArray: [-260],
              rightBrunchesYArray: [],

              normalNutsPositionsArray: [CGPoint(x: -100, y: 300), CGPoint(x: 100, y: 180)],
              boxNutPositionsArray: [CGPoint(x: 0, y: -360)]),

        //13
        Frame(leftSpinesPositionsArray: [(-360, 3)],
              rightSpinesPositionsArray: [(160, 1)],

              leftBrunchesYArray: [320, -40],
              rightBrunchesYArray: [],

              normalNutsPositionsArray: [CGPoint(x: 100, y: 360), CGPoint(x: -100, y: 190), CGPoint(x: 0, y: -120), CGPoint(x: 100, y: -400)],
              boxNutPositionsArray: [])

        
        //
//        Frame(leftSpinesPositionsArray: <#T##[(CGFloat, Int)]#>,
//              rightSpinesPositionsArray: <#T##[(CGFloat, Int)]#>,
//
//              leftBrunchesYArray: <#T##[CGFloat]#>,
//              rightBrunchesYArray: <#T##[CGFloat]#>,
//
//              normalNutsPositionsArray: <#T##[CGPoint]#>,
//              boxNutPositionsArray: <#T##[CGPoint]#>)
    ]
}

enum SoundFile {
    static let backgroundMusicMenu = "bensound-cute.mp3"
    static let backgroundMusicGame = "PixelLoop.m4a"
    static let pickUpSound = "nut+1.m4a"
    static let gameOver = "Game over.m4a"
    static let jump = "Jumping.m4a"
    static let boxNut = "nut box.m4a"
}
