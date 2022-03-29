//
//  GameOverView.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import AVFoundation
import SwiftUI

/**
 * # GameOverView
 *   This view is responsible for showing the game over state of the game.
 *  Currently it only present buttons to take the player back to the main screen or restart the game.
 *
 *  You can also present score of the player, present any kind of achievements or rewards the player
 *  might have accomplished during the game session, etc...
 **/

struct GameOverView: View {
    
    @Binding var currentGameState: GameState
    @State var backgroundMusicAV : AVAudioPlayer!
    
    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                Spacer()

                Button {
                    withAnimation { self.backToMainScreen() }
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
                }
                .background(Circle().foregroundColor(Color(uiColor: UIColor.brown)).frame(width: 100, height: 100, alignment: .center))
                
                Spacer()
                
                Button {
                    withAnimation { self.restartGame() }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
                }
                .background(Circle().foregroundColor(Color(uiColor: UIColor.brown)).frame(width: 100, height: 100, alignment: .center))
                
                Spacer()
                Spacer()
            }
        }
        .statusBar(hidden: true)
        .onAppear {
            if let sound = Bundle.main.path(forResource: "bensound-cute", ofType: "mp3") {
            self.backgroundMusicAV = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            backgroundMusicAV.play()
            }
        }
    }
    
    private func backToMainScreen() {
        backgroundMusicAV.stop()
        self.currentGameState = .mainScreen
    }
    
    private func restartGame() {
        backgroundMusicAV.stop()
        self.currentGameState = .playing
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(currentGameState: .constant(GameState.gameOver))
    }
}
