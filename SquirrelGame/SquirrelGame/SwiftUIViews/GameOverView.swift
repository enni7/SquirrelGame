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
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
//                VStack{
//                    HStack{
//                        Text("TIME:")
//                        Spacer()
//                        Text("\(Int(gameLogic.finalTime))")
//                    }
//                    .padding(.horizontal)
//                    .padding(10)
//                    HStack{
//                        Text("POINTS:")
//                        Spacer()
//                        Text("\(gameLogic.finalPoints)")
//                    }
//                    .padding(.horizontal)
//                    .padding(10)
                VStack{
                    VStack{
                        Image("hurtFace 1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding()
                            
                        Text("SCORE")
//                            .foregroundColor(.white)
                            .bold()
                            .padding(.vertical,5)
                            .font(.system(.title, design: .monospaced))


                        Text("\(gameLogic.finalScore)")
                            .bold()
                            .font(.system(.largeTitle, design: .monospaced))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 250)

//                }
                .background(Rectangle().cornerRadius(15).foregroundColor(Color(uiColor: UIColor(named: "darkBrown")!)))
                .font(.system(.title, design: .monospaced))
                .foregroundColor(Color(uiColor: UIColor(named: "lighterBrown")!))
//                .padding(.horizontal, 50)
                .padding(.bottom, 20)
                
                HStack{
                    Button {
                        withAnimation { self.backToMainScreen() }
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color(uiColor: UIColor(named: "lighterBrown")!))
                            .font(.largeTitle)
                            .padding(25)
                    }
                    .background(Rectangle().cornerRadius(15).foregroundColor(Color(uiColor: UIColor(named: "darkBrown")!)).frame(width: 80, height: 80, alignment: .center))
                    
                    Spacer()
                    
                    Button {
                        withAnimation { self.restartGame() }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(Color(uiColor: UIColor(named: "lighterBrown")!))
                            .font(.largeTitle)
                            .padding(25)
                            .background(Rectangle().cornerRadius(15).foregroundColor(Color(uiColor: UIColor(named: "darkBrown")!)).frame(width: 80, height: 80, alignment: .center))

                    }
                }.frame(width: 250)
                }
                Spacer()
            }
        }
        .statusBar(hidden: true)
        .onAppear {
            if let sound = Bundle.main.path(forResource: "bensound-cute", ofType: "mp3") {
                self.backgroundMusicAV = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                backgroundMusicAV.numberOfLoops = -1
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
