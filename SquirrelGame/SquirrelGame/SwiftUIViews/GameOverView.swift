//
//  GameOverView.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import AVFoundation
import SwiftUI

struct GameOverView: View {
    
    @Binding var currentGameState: GameState
    var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared
    @State var backgroundMusicAV : AVAudioPlayer!
    @State var disabled: Bool = true
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                VStack{
                    VStack{
                        if gameLogic.isBestScore(){
                        Text("NEW RECORD!")
                            .bold()
                            .padding(.vertical,5)
                            .font(.system(.title, design: .monospaced))
                        }
                        
                        Image("hurtFace 1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding()
                        
                        Text("SCORE")
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
                    
                    .background(Rectangle().cornerRadius(15).foregroundColor(Color(uiColor: UIColor(named: "darkBrown")!)))
                    .font(.system(.title, design: .monospaced))
                    .foregroundColor(Color(uiColor: UIColor(named: "lighterBrown")!))
                    .padding(.bottom, 20)
                    
                    HStack{
                        Button {
                            withAnimation(.easeOut(duration: 0.3)) { self.backToMainScreen() }
                        } label: {
                            ZStack {
                                Rectangle().cornerRadius(15).foregroundColor(Color(uiColor: UIColor(named: "darkBrown")!)).frame(width: 80, height: 80, alignment: .center)
                                Image(systemName: "arrow.backward")
                                    .foregroundColor(Color(uiColor: UIColor(named: "lighterBrown")!))
                                    .font(.largeTitle)
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            withAnimation { self.restartGame() }
                        } label: {
                            ZStack {
                                Rectangle().cornerRadius(15).foregroundColor(Color(uiColor: UIColor(named: "darkBrown")!)).frame(width: 80, height: 80, alignment: .center)
                                Image(systemName: "arrow.clockwise")
                                    .foregroundColor(Color(uiColor: UIColor(named: "lighterBrown")!))
                                    .font(.largeTitle)
                            }
                        }
                        .disabled(disabled)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                disabled = false
                            }
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
                if self.backgroundMusicAV.isPlaying == false {

                backgroundMusicAV.numberOfLoops = -1
                backgroundMusicAV.play()
            }
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
