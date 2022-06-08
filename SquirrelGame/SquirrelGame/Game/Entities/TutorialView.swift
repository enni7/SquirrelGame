//
//  TutorialView.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 08/06/22.
//

import SwiftUI
import CoreGraphics
import UIKit

struct TutorialView: View {
    @Binding var tutorialPage: Int
    @Binding var showTutorial: Bool
    var body: some View {
        VStack(spacing: 0){
            VStack(spacing: 0){
                if tutorialPage == 1 {
                    VStack(spacing: 0){
                        Image("tutorial1")
                            .resizable()
                            .scaledToFit()
                        Text("Tap to jump on the other tree")
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .transition(.slide)
                            .font(.system(.callout, design: .monospaced))
                            .foregroundColor(Color("darkerBrown"))
                            .padding(4)
                            .frame(maxWidth: .infinity)
                            .frame(height: 120)
                        
                            .background(Color("lightYellow"))
                    }
                    .padding(1)
                    .clipped()
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
                    
                } else {
                    VStack(spacing: 0){
                        Image("tutorial2")
                            .resizable()
                            .scaledToFit()
                        
                        Text("Tap while you’re on a nut box to break it, but if you fail Aki the squirrel will fall down!")
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .transition(.slide)
                            .font(.system(.callout, design: .monospaced))
                            .foregroundColor(Color("darkerBrown"))
                            .padding(4)
                            .frame(maxWidth: .infinity)
                            .frame(height: 120)
                        
                            .background(Color("lightYellow"))
                    }
                    .padding(1)
                    .clipped()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
            .clipped()
            .padding([.horizontal, .top], 30)
            
            
            VStack(spacing: 0){
                HStack(spacing: 8){
                    Circle()
                        .fill(Color(tutorialPage == 1 ? "lightYellow" : "lightBrown"))
                        .frame(width: 14, height: 14)
                    Circle()
                        .fill(Color(tutorialPage == 1 ? "lightBrown" : "lightYellow"))
                        .frame(width: 14, height: 14)
                }
                .padding(.vertical, 20)
                Button {
                    if tutorialPage == 1 {
                    tutorialPage += 1
                } else {
                    showTutorial = false
                    tutorialPage = 0
                }
                    
                } label: {
                    Text(tutorialPage == 1 ? "NEXT" : "PLAY")
                        .font(.system(.title2, design: .monospaced))
                        .fontWeight(.bold)
                        .foregroundColor(Color("lightYellow"))
                }
                .padding(.bottom, 20)
            }
        }
        .background(Color("darkBrown"))
        .cornerRadius(17)
        .animation(.easeInOut, value: tutorialPage)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(tutorialPage: .constant(1), showTutorial: .constant(true))
    }
}
