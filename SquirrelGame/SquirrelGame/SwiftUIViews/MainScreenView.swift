//
//  MainScreenView.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import AVFoundation
import SwiftUI
import GameKit


struct MainScreenView: View {
    
    // The game state is used to transition between the different states of the game
    @Binding var currentGameState: GameState
    
    // Change it on the Constants.swift file
    var gameTitle: String = MainScreenProperties.gameTitle
    
    // Change it on the Constants.swift file
    var gameInstructions: [Instruction] = MainScreenProperties.gameInstructions
    
    // Change it on the Constants.swift file
    let accentColor: Color = MainScreenProperties.accentColor
    @StateObject var gameLogic = ArcadeGameLogic.shared
    
    @State var presentGameCenterAlert = false
    @State var presentTutorial = true
    
    @State var bestScore: Int = UserDefaults.standard.integer(forKey: "bestScore")
    
    @State var isAnimatingColor = false
    var body: some View {
        ZStack{
            VStack(alignment: .center) {
                Group{
                    Spacer()
                    Image("LOGO")
                        .resizable()
                        .scaledToFit()
                        .padding(20)
                    Spacer()
                }
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8){
                    HStack{
                        Text("YOUR BEST")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Spacer()
                        Text(gameLogic.bestScore.formatted())
                            .fontWeight(.semibold)
                            .foregroundColor(Color(uiColor: UIColor(named: "lighterBrown")!))
                            .padding(.trailing, 24)
                    }
                    .font(.system(.title, design: .monospaced))
                    .padding(14)
                    .background(Color(uiColor: UIColor(named: "darkBrown")!))
                    .cornerRadius(15)
                    
                    Button {
                        showLeaderBoard()
                    } label: {
                        HStack{
                            Text("RANKING")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            Spacer()
                            
                            Text("#\(gameLogic.globalRank.formatted())")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(uiColor: UIColor(named: "darkBrown")!))
                                .padding(.trailing, 24)
                        }
                        .font(.system(.title, design: .monospaced))
                        .padding(14)
                        .background(Color(uiColor: UIColor(named: "lighterBrown")!))
                        .cornerRadius(15)
                    }
                    .alert("Game Center account not found", isPresented: $presentGameCenterAlert) {
                    } message: {
                        Text("Please login to Game Center from settings to see the leaderboard.")
                    }
                    .padding(.bottom, 50)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(self.gameInstructions, id: \.title) { instruction in
                            
                            HStack{
                                Image(systemName: "\(instruction.icon)")
                                    .font(.system(.title, design: .monospaced))
                                    .foregroundColor(Color(uiColor: UIColor(named: "lighterBrown")!))
                                    .padding([.vertical, .leading])
                                Text("\(instruction.title)")
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.white)
                                    .font(.system(.title3, design: .monospaced))
                                    .padding(10)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    .padding(6)
                    .background(Rectangle().cornerRadius(15).foregroundColor(Color(uiColor: UIColor(named: "darkBrown")!)))
                }
                .padding(20)
                
                Button {
                    withAnimation { self.startGame() }
                } label: {
                    Text("START")
                        .bold()
                        .font(.system(.title, design: .monospaced))
                        .foregroundColor(.white)
                        .colorMultiply(isAnimatingColor ? .white : Color(uiColor: UIColor(named: "darkBrown")!))
                        .padding()
                        .background(Color(uiColor: UIColor(named: "lighterBrown")!))
                        .onAppear{
                            withAnimation(.spring(response: 0.06, dampingFraction: 2.5).repeatForever(autoreverses: true)) {
                                self.isAnimatingColor = true
                            }
                        }
                    
                }
                .cornerRadius(15)
                .padding()
                Spacer()
            }
            .padding()
            
            if presentTutorial{

                VStack{
                    TutorialView()
                        .padding(.vertical, 50)
                        .padding(.horizontal, 30)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .statusBar(hidden: true)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                presentTutorial = true
            }
        }
    }
    
    func showLeaderBoard(){
        if GKLocalPlayer.local.isAuthenticated {
            GKAccessPoint.shared.trigger(state: .leaderboards) {
                //
            }
        } else {
            presentGameCenterAlert.toggle()
        }
    }
    
    private func startGame() {
        print("- Starting the game...")
        self.currentGameState = .playing
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(currentGameState: .constant(GameState.mainScreen))
    }
}
