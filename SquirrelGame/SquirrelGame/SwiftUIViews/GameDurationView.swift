//
//  GameDurationView.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 29/03/22.
//

import SwiftUI

/**
 * # GameDurationView
 * Custom UI to present how many seconds have passed since the beginning of the gameplay session.
 *
 * Customize it to match the visual identity of your game.
 */

struct GameDurationView: View {
    @Binding var time: TimeInterval
    
    var body: some View {
        HStack {
            Image("Clock")
            Text(String(format: "%.1f", Double(time)))
                .font(.system(.title2, design: .monospaced))
                .bold()
        }
        .padding(24)
        .foregroundColor(Color(UIColor.systemOrange))
    }
}

struct GameDurationView_Previews: PreviewProvider {
    static var previews: some View {
        GameDurationView(time: .constant(1000))
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
