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
    var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared

    
    var body: some View {
        ZStack {
            Color(uiColor: UIColor.cyan)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                VStack{
                    HStack{
                        Text("TIME:")
                        Spacer()
                        Text("\(Int(gameLogic.finalTime))")
                    }
                    .padding(.horizontal)
                    .padding(10)
                    HStack{
                        Text("POINTS:")
                        Spacer()
                        Text("\(gameLogic.finalPoints)")
                    }
                    .padding(.horizontal)
                    .padding(10)
                    VStack{
                        Text("TOTAL SCORE")
                            .bold()

                        Text("\(gameLogic.finalScore)")
                            .bold()
                            .font(.system(.largeTitle, design: .monospaced))
                    }
                    .padding()
                    
                }
                .background(Rectangle().cornerRadius(10).foregroundColor(Color(uiColor: UIColor.systemGroupedBackground)))
                .font(.system(.title, design: .monospaced))
                .foregroundColor(Color(uiColor: UIColor.systemOrange))
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
                
                
                HStack{
                    Spacer()
                    Button {
                        withAnimation { self.backToMainScreen() }
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color(uiColor: UIColor.systemOrange))
                            .font(.largeTitle)
                    }
                    .background(Rectangle().cornerRadius(10).foregroundColor(Color(uiColor: UIColor.systemGroupedBackground)).frame(width: 80, height: 80, alignment: .center))
                    
                    Spacer()
                    
                    Button {
                        withAnimation { self.restartGame() }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(Color(uiColor: UIColor.systemOrange))
                            .font(.largeTitle)
                    }
                    .background(Rectangle().cornerRadius(10).foregroundColor(Color(uiColor: UIColor.systemGroupedBackground)).frame(width: 80, height: 80, alignment: .center))
                    Spacer()
                }
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
