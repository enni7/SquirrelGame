//
//  GameCenterHelper.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 05/06/22.
//

import Foundation
import GameKit
import SwiftUI

class GameKitHelper: NSObject, GKGameCenterControllerDelegate {
    
    static let shared = GameKitHelper()
    
    var gameCenterEnabled: Bool
    
    private override init() {
        gameCenterEnabled = true
        super.init()
    }
        
    func updateScore(with value: Int) {
        if (self.gameCenterEnabled) {
            GKLeaderboard.submitScore(value, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["runut_highscoreLeaderboard1"], completionHandler: {error in
                print(error?.localizedDescription as Any)
            })
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
