//
//  ArcadeGameView.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import AVFoundation
import SwiftUI
import SpriteKit

/**
 * # ArcadeGameView
 *   This view is responsible for presenting the game and the game UI.
 **/

struct ArcadeGameView: View {
        
    // The Game Logic
    @StateObject var gameLogic: ArcadeGameLogic =  ArcadeGameLogic.shared
    
    // The game state is used to transition between the different states of the game
    @Binding var currentGameState: GameState
    
    @State var notificationCenter = NotificationCenter.default

    private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    // The Game Scene
    let arcadeGameScene = ArcadeGameScene()
    
    var body: some View {
        ZStack(alignment: .top) {
            // View that presents the game scene
            SpriteView(scene: self.arcadeGameScene)
                .frame(width: screenWidth, height: screenHeight)
                .statusBar(hidden: true)
            
            HStack() {
                Spacer()
                GameScoreView(score: $gameLogic.currentScore)
                Spacer()
            }
            .padding([.horizontal, .top], 24)
        }
        .onChange(of: gameLogic.isGameOver) { _ in
            if gameLogic.isGameOver {
                withAnimation(.easeOut(duration: 0.3)) {
                    self.presentGameOverScreen()
                }
            }
        }
        .onAppear {
            arcadeGameScene.size = CGSize(width: screenWidth, height: screenHeight)
            arcadeGameScene.scaleMode = .aspectFill
        }
    }
    
    /**
     * ### Function responsible for presenting the main screen
     * At the moment it is not being used, but it could be used in a Pause menu for example.
     */
    private func presentMainScreen() {
        self.currentGameState = .mainScreen
    }
    
    /**
     * ### Function responsible for presenting the game over screen.
     * It changes the current game state to present the GameOverView.
     */
    private func presentGameOverScreen() {
        self.currentGameState = .gameOver
    }
    private func pauseGame(){
        self.arcadeGameScene.isPaused = true
    }
    private func unpauseGame(){
        self.arcadeGameScene.isPaused = false
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        ArcadeGameView(currentGameState: .constant(GameState.playing))
    }
}
