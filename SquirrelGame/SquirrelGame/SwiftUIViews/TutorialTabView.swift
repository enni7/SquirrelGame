//
//  TutorialTabView.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 08/06/22.
//

import SwiftUI

struct TutorialTabView: View {
    @State var isInGameView: Bool
    @State var tutorialPage: Int
    @Binding var presentTutorial: Bool

    @State var buttonText: String = "SKIP"
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0){
                TabView(selection: $tutorialPage){
                    TutorialPage(tutorialPage: 1)                        .padding(.bottom)
                        .tag(1)
//                        .onAppear{
//                            tutorialPage = 1
//                        }
                    TutorialPage(tutorialPage: 2)
                        .padding(.bottom)
                        .tag(2)
//                        .onAppear{
//                            tutorialPage = 2
//                        }
                }
                .tabViewStyle(.page)
                .padding(.horizontal, 30)
                Button {
                    presentTutorial = false
                    tutorialPage = 0
                } label: {
                    Text(buttonText)
                        .font(.system(.title2, design: .monospaced))
                        .fontWeight(.bold)
                        .foregroundColor(Color("lightYellow"))
                }
                .padding(.bottom, 20)
                .padding(.vertical)
            }
            .background(RoundedRectangle(cornerRadius: 17).foregroundColor(Color("darkBrown")))
        }
        .onChange(of: tutorialPage) { newValue in
            if newValue == 2 {
                buttonText = isInGameView ? "PLAY" : "TAP TO CONTINUE"
            } else {
                buttonText = isInGameView ? "SKIP" : "SKIP"
            }
        }
    }
}

struct TutorialTabView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialTabView(isInGameView: false, tutorialPage: 1, presentTutorial: .constant(true))
    }
}
