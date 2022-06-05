//
//  ArcadeGameLogic.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import Foundation
import GameKit

class ArcadeGameLogic: ObservableObject {
    
    // Keeps track of the current score of the player
    @Published var currentScore: Int = 0
    // Keep tracks of the duration of the current session in number of seconds
    @Published var sessionDuration: TimeInterval = 0
    // Game Over Conditions
    @Published var isGameOver: Bool = false
    //Final score
    @Published var finalScore: Int = 0
    @Published var globalRank: Int = 0
    var bestOld = UserDefaults.standard.integer(forKey: "bestScore")
    
    var bestScore: Int {
        return UserDefaults.standard.integer(forKey: "bestScore")
    }
    
    // Single instance of the class
    static let shared: ArcadeGameLogic = ArcadeGameLogic()
    
    // Function responsible to set up the game before it starts.
    func setUpGame() {
                
        self.currentScore = 0
        self.sessionDuration = 0
        
        self.isGameOver = false
    }
    
    // Increases the score by a certain amount of points
    func score(points: Int) {
        self.currentScore = self.currentScore + points
    }
        
    func increaseSessionTime(by timeIncrement: TimeInterval) {
        self.sessionDuration = self.sessionDuration + timeIncrement
    }
    
    func restartGame() {
        self.setUpGame()
    }
        
    func isNewRecord() -> Bool {
        if finalScore > bestOld {
            return true
        } else {
            return false
        }
    }
    
    func isBestScore() -> Bool {
        if finalScore > bestScore {
            return true
        } else {
            return false
        }
    }
    
    func updateBestScore() {
        if isBestScore() {
            UserDefaults.standard.set(finalScore, forKey: "bestScore")
        }
    }
    
    func finishTheGame() {
        if self.isGameOver == false {
            self.isGameOver = true
        }
    }
    
    func updateGameCenterScore(score: Int){
        if GKLocalPlayer.local.isAuthenticated {
            GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["runut_highscoreLeaderboard1"]) { error in
                if let error = error {
                    print("An error occurred during the leaderboard update. \(error.localizedDescription)")
                }
            }
        }
    }
    func updateGameCenterScoreWithFinalScore(){
        updateGameCenterScore(score: finalScore)
    }
}
