//
//  TutorialTabView.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 08/06/22.
//

import SwiftUI

struct TutorialTabView: View {
    @StateObject var gameLogic = ArcadeGameLogic.shared
    @State var isInGameView: Bool
    @State var tutorialPage: Int
    var playFunc: () -> Void
    @State var buttonText: String
    var tint : Color {
        if isInGameView && tutorialPage == 1 {
            return .clear
        } else {
            return  Color("lighterBrown")
        }
    }
    var textButtonColor : Color {
        if isInGameView && tutorialPage == 1 {
            return Color("lighterBrown")
        } else {
            return Color("darkBrown")
        }
    }
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0){
                TabView(selection: $tutorialPage){
                    TutorialPage(tutorialPage: 1)
                        .padding(.vertical, 30)
                        .tag(1)
                    TutorialPage(tutorialPage: 2)
                        .padding(.vertical, 30)
                        .tag(2)
                }
                .tabViewStyle(.page)
                .padding(.horizontal, 30)
                Button() {
                    if isInGameView{
                        gameLogic.presentTutorial = false
                        tutorialPage = 0
                        withAnimation {
                            playFunc()
                        }
                    } else {
                    gameLogic.presentTutorial = false
                    tutorialPage = 0
                        
                    }
                } label: {
                    Text(buttonText)
                        .font(.system(.title2, design: .monospaced))
                        .fontWeight(.bold)
                        .foregroundColor(textButtonColor)
                }
                .buttonStyle(.borderedProminent)
                .tint(tint)
                .overlay{
                    if isInGameView && tutorialPage == 1 {
                        
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("lighterBrown"), lineWidth: 2)
                    }
                }
                
                .padding(.bottom, 20)
                .padding(.vertical)
            }
            .background(RoundedRectangle(cornerRadius: 17).foregroundColor(Color("darkBrown")))
        }
        
        .onChange(of: tutorialPage) { newValue in
            if !isInGameView{
                buttonText = "GOT IT"
            } else {
                buttonText = newValue == 1 ? "SKIP" : "PLAY"
            }
        }
    }
}

//struct TutorialTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TutorialTabView(isInGameView: true, tutorialPage: 1, buttonText: "SKIP", playFunc: () -> Void)
//    }
//}
