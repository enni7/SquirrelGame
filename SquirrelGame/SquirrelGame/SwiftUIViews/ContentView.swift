//
//  ContentView.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import AVFoundation
import SwiftUI

/**
 * # ContentView
 *   Manages the states of the game, presenting the proper view.
 **/

struct ContentView: View {
    
    @State var backgroundMusicAV : AVAudioPlayer!

    // The navigation of the app is based on the state of the game.
    // Each state presents a different view on the SwiftUI app structure
    @State var currentGameState: GameState = .mainScreen
    
    // The game logic is a singleton object shared among the different views of the application
    @StateObject var gameLogic: ArcadeGameLogic = ArcadeGameLogic()
    
    var body: some View {
        ZStack{
        switch currentGameState {
        case .mainScreen:
            MainScreenView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
                .ignoresSafeArea()
            
        case .playing:
            ArcadeGameView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
                .ignoresSafeArea()
        
        case .gameOver:
            GameOverView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
                .ignoresSafeArea()
        }
        }
        .ignoresSafeArea(.all, edges: .all)
        .onAppear {
            self.playMusic(forMenu: true)
        }
        .onChange(of: currentGameState) { newValue in
            if newValue == .playing {
                self.backgroundMusicAV.stop()
                self.playMusic(forMenu: false)
            } else if newValue == .gameOver {
                self.backgroundMusicAV.stop()
                self.playMusic(forMenu: true)
            }
        }
    }
    
    func playMusic(forMenu trueIfMenu: Bool){
        if let sound = Bundle.main.path(forResource: trueIfMenu ? "bensound-cute" : "PixelLoop", ofType: trueIfMenu ? "mp3" : "m4a") {
            self.backgroundMusicAV = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            if self.backgroundMusicAV.isPlaying == false {
                
                backgroundMusicAV.numberOfLoops = -1
                                backgroundMusicAV.play()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
