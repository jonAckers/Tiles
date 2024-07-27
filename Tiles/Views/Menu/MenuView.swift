//
//  MenuView.swift
//  Tiles
//
//  Created by Jon Ackers on 27/07/2024.
//

import SwiftUI

struct MenuView: View {
    // MARK: - Properties

    let darkColor = Color(red: 0.19, green: 0.22, blue: 0.22, opacity: 1)
    let lightColor = Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)

    let continueGameAction: () -> Void
    let newGameAction: () -> Void

    // MARK: - Conformance to View Protocol

    var body: some View {
        ZStack {
            VStack {
                Text("Tiles")
                    .font(.system(size: 64).weight(.black))
                    .foregroundStyle(darkColor)
                    .frame(maxWidth: .infinity)

                Spacer()

                Button {
                    // Continue Game
                    continueGameAction()
                } label: {
                    Text("Continue")
                        .font(.system(size: 24).weight(.bold))
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.48, green: 0.70, blue: 0.48, opacity: 1))
                        .cornerRadius(10)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)

                Button {
                    // Start new game
                    newGameAction()
                } label: {
                    Text("New Game")
                        .font(.system(size: 24).weight(.bold))
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.27, green: 0.51, blue: 0.27, opacity: 1))
                        .cornerRadius(10)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)

                Button {
                    // Open leaderboard
                } label: {
                    Text("Leaderboard")
                        .font(.system(size: 24).weight(.bold))
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.29, green: 0.48, blue: 0.73, opacity: 1))
                        .cornerRadius(10)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .disabled(true)

                Spacer()
                Spacer()
                Spacer()
            }
            .padding(20)
            .tint(lightColor)
        }
    }
}

#Preview {
    MenuView(continueGameAction: {}, newGameAction: {})
}
