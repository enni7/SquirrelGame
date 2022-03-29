//
//  ArcadeGameLogic.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import Foundation

class ArcadeGameLogic: ObservableObject {
    @Published var finalTime: Int = 0
    @Published var finalPoints: Int = 0
    @Published var finalScore: Int = 0

    // Single instance of the class
    static let shared: ArcadeGameLogic = ArcadeGameLogic()
    
    // Function responsible to set up the game before it starts.
    func setUpGame() {
        
        // TODO: Customize!
        
        self.currentScore = 0
        self.sessionDuration = 0
        self.finalScore = 0
        
        self.isGameOver = false
    }
        
    // Keeps track of the current score of the player
    @Published var currentScore: Int = 0
    
    // Increases the score by a certain amount of points
    func score(points: Int) {
        self.currentScore = self.currentScore + points
    }
    
    // Keep tracks of the duration of the current session in number of seconds
    @Published var sessionDuration: TimeInterval = 0
    
    func increaseSessionTime(by timeIncrement: TimeInterval) {
        self.sessionDuration = self.sessionDuration + timeIncrement
    }
    
    func restartGame() {
        
        // TODO: Customize!
        
        self.setUpGame()
    }
    
    // Game Over Conditions
    @Published var isGameOver: Bool = false
    
    func finishTheGame() {
        self.finalScore = finalTime + finalPoints
        if self.isGameOver == false {
            self.isGameOver = true
        }
    }
}
