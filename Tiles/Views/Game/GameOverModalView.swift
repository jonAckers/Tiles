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

    var body: some View {
        ZStack {
            Color.secondaryAccent
                .ignoresSafeArea()

            VStack {
                Text("Game Over!")
                    .font(.system(size: 42).weight(.black))
                    .foregroundStyle(Color.primaryAccent)

                Text("Your score: \(score)")
                    .font(.system(size: 21).weight(.bold))
                    .foregroundStyle(Color.primaryAccent.opacity(0.6))

                Spacer()

                Button {
                    resetAction()
                } label: {
                    Text("New game?")
                        .font(.system(size: 21).weight(.bold))
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color.primaryAccent)
                        .clipShape(.capsule)
                }
                .tint(Color.secondaryAccent)

                Spacer()
            }
            .padding(20)
        }
    }
}

#Preview {
    GameOverModalView(score: 1234, resetAction: {})
}
