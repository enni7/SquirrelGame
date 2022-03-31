//
//  GameScoreView.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import SwiftUI

/**
 * # GameScoreView
 * Custom UI to present how many points the player has scored.
 *
 * Customize it to match the visual identity of your game.
 */

struct GameScoreView: View {
    @Binding var score: Int
    
    var body: some View {
        
        HStack {
//            Image("nut_111")
            Text("SCORE: \(score)")
                .font(.system(.title2, design: .monospaced))
                .bold()
                .padding()
                .background(Color(uiColor: UIColor(named: "lighterBrown")!))
        }
        .cornerRadius(15)
        .padding(24)
        .foregroundColor(Color(UIColor(named: "darkBrown")!))
    }
}

struct GameScoreView_Previews: PreviewProvider {
    static var previews: some View {
        GameScoreView(score: .constant(100))
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
