//
//  MainScreenView.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import AVFoundation
import SwiftUI


struct MainScreenView: View {
    
    @State var backgroundMusicAV : AVAudioPlayer!
    
    // The game state is used to transition between the different states of the game
    @Binding var currentGameState: GameState
    
    // Change it on the Constants.swift file
    var gameTitle: String = MainScreenProperties.gameTitle
    
    // Change it on the Constants.swift file
    var gameInstructions: [Instruction] = MainScreenProperties.gameInstructions
    
    // Change it on the Constants.swift file
    let accentColor: Color = MainScreenProperties.accentColor
    var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared

    @State var bestScore: Int = UserDefaults.standard.integer(forKey: "bestScore")
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 16.0) {
                Spacer()
                Image("LOGO")
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical)
                    .padding(.horizontal, 40)
                
                Spacer()
                VStack {
                    Text("YOUR BEST")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
//                    Text(bestScore.formatted())
                    Text(bestScore.formatted())
                        .fontWeight(.semibold)
                }
                .font(.system(.title, design: .monospaced))
                .foregroundColor(Color(uiColor: UIColor(named: "lighterBrown")!))
                .padding(15)
                .background(Color(uiColor: UIColor(named: "darkBrown")!))
                .cornerRadius(15)
                .padding()
                
                Spacer()
                VStack(alignment: .leading) {
                    ForEach(self.gameInstructions, id: \.title) { instruction in
                        
                        HStack{
                            Image(systemName: "\(instruction.icon)")
                                .font(.system(.title, design: .monospaced))
                                .foregroundColor(Color(uiColor: UIColor(named: "lighterBrown")!))
                                .padding(10)
                                Text("\(instruction.title)")
                                .multilineTextAlignment(.leading)
//                                    .font(.custom("BMDoHyeon-Regular.ttf", size: 24))
                                    .foregroundColor(.white)
                                    .font(.system(.title3, design: .monospaced))
                        }
                        .padding(.vertical)
                    }
                }
                .background(Rectangle().cornerRadius(15).foregroundColor(Color(uiColor: UIColor(named: "darkBrown")!)))
                .padding(.horizontal, 40)
                Spacer()
                
                Button {
                    withAnimation { self.startGame() }
                } label: {
                    Text("START")
                        .bold()
                        .font(.system(.title, design: .monospaced))
                        .foregroundColor(Color(uiColor: UIColor(named: "darkBrown")!))
                        .padding()
                        .background(Color(uiColor: UIColor(named: "lighterBrown")!))
                    
                }
                .cornerRadius(15)
                Spacer()
            }
            .padding()
        }
        .statusBar(hidden: true)
        .onAppear {
            if UserDefaults.standard.contains(key: "bestScore") == false {
                UserDefaults.standard.set(0, forKey: "bestScore")
            }

            if let sound = Bundle.main.path(forResource: "bensound-cute", ofType: "mp3") {
                self.backgroundMusicAV = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                if self.backgroundMusicAV.isPlaying == false {

                backgroundMusicAV.numberOfLoops = -1
                backgroundMusicAV.play()
                }
            }
        }
    }
    
    private func startGame() {
        print("- Starting the game...")
        self.backgroundMusicAV.stop()
        self.currentGameState = .playing
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(currentGameState: .constant(GameState.mainScreen))
    }
}
