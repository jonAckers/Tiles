//
//  GameOverModalView.swift
//  Tiles
//
//  Created by Jon Ackers on 21/07/2024.
//

import SwiftUI

struct GameOverModalView: View {
    let score: Int
    let resetAction: () -> Void

    let darkColor = Color(red: 0.19, green: 0.22, blue: 0.22, opacity: 1)
    let darkColorSecondary = Color(red: 0.19, green: 0.22, blue: 0.22, opacity: 0.6)
    let lightColor = Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)

    var body: some View {
        VStack {
            Text("Game Over!")
                .font(.system(size: 42).weight(.black))
                .foregroundStyle(darkColor)

            Text("Your score: \(score)")
                .font(.system(size: 21).weight(.bold))
                .foregroundStyle(darkColorSecondary)

            Spacer()

            Button {
                resetAction()
            } label: {
                Text("New game?")
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(darkColor)
                    .clipShape(.capsule)
            }
            .tint(lightColor)

            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    GameOverModalView(score: 1234, resetAction: {})
}
