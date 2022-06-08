//
//  TutorialPage.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 08/06/22.
//

import SwiftUI

struct TutorialPage: View {
    @State var tutorialPage: Int
        
    var image: String{
        if tutorialPage == 2 {
            return "tutorial22"
        } else {
            return "tutorial11"
        }
    }
    
    var textDescription : String {
        if tutorialPage == 2 {
            return "Tap while you’re on a nut box to break it, but if you fail Aki the squirrel will fall down!"
        } else {
            return "Tap to jump on the other tree"
        }
    }
    var body: some View {
        VStack(spacing: 0){
            GeometryReader(){ geo in
                VStack(spacing: 0){
                Image(image)
                    .resizable()
                    .scaledToFit()
//                    .frame(width: geo.size.width)
                    .clipped()

//                Text(textDescription)
//                    .fontWeight(.medium)
//                    .multilineTextAlignment(.center)
//                    .font(.system(.callout, design: .monospaced))
//                    .foregroundColor(Color("darkerBrown"))
//                    .padding(4)
//                    .frame(width: geo.size.width, height: geo.size.height * 0.2)
//                    .background(Color("lightYellow"))
                }
            }
        }
    }
}

struct TutorialPage_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPage(tutorialPage: 1)
    }
}
