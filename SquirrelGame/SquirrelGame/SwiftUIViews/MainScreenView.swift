//
//  MainScreenView.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import AVFoundation
import SwiftUI

/**
 * # MainScreenView
 *
 *   This view is responsible for presenting the game name, the game intructions and to start the game.
 *  - Customize it as much as you want.
 *  - Experiment with colors and effects on the interface
 *  - Adapt the "Insert a Coin Button" to the visual identity of your game
 **/

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
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 16.0) {
                Spacer()
                
                /**
                 * # PRO TIP!
                 * The game title can be customized to represent the visual identity of the game
                 */
                Text("\(self.gameTitle)")
                    .font(.title)
                    .fontWeight(.black)
                
                Spacer()
                
                /**
                 * To customize the instructions, check the **Constants.swift** file
                 */
                VStack {
                    ForEach(self.gameInstructions, id: \.title) { instruction in
                        
                        HStack{
                            Image(systemName: "\(instruction.icon)")
                                .font(.system(.title2, design: .monospaced))
                                .foregroundColor(Color(uiColor: UIColor(named: "lightBrown")!))
                                .padding()
                            Spacer()
                            VStack{
                                Text("\(instruction.title)")
                                    .font(.system(.title2, design: .monospaced))
                                    .foregroundColor(Color(uiColor: UIColor(named: "darkBrown")!))
                                //                        Text("\(instruction.description)")
                                //                            .font(.system(.title3, design: .monospaced))
                            }
                            Spacer()
                        }
                        .padding(.vertical)
                    }
                }
                .frame(width: 300)
                .background(Rectangle().cornerRadius(15).foregroundColor(Color(uiColor: UIColor(named: "cloud")!)))
                
                Spacer()
                
                /**
                 * Customize the appearance of the **Insert a Coin** button to match the visual identity of your game
                 */
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
            if let sound = Bundle.main.path(forResource: "bensound-cute", ofType: "mp3") {
                self.backgroundMusicAV = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                backgroundMusicAV.play()
            }
        }
    }
    
    /**
     * Function responsible to start the game.
     * It changes the current game state to present the view which houses the game scene.
     */
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
