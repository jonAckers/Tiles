//
//  MenuView.swift
//  Tiles
//
//  Created by Jon Ackers on 27/07/2024.
//

import SwiftUI

struct MenuView: View {
    // MARK: - Properties

    let continueGameAction: () -> Void
    let newGameAction: () -> Void
    let loadScoreboardAction: () -> [ScoreData]

    @State private var isShowingScoreboard = false

    // MARK: - Conformance to View Protocol

    var body: some View {
        ZStack {
            VStack {
                Text("Tiles")
                    .font(.system(size: 96).weight(.black))
                    .foregroundStyle(Color.primaryAccent)
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
                        .background(Color.tile8)
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
                        .background(Color.tile32)
                        .cornerRadius(10)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)

                Button {
                    // Open scoreboard
                    isShowingScoreboard.toggle()
                } label: {
                    Text("Scoreboard")
                        .font(.system(size: 24).weight(.bold))
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color.tile128)
                        .cornerRadius(10)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .sheet(isPresented: $isShowingScoreboard) {
                    ScoreboardView(loadScoreboardAction())
                }

                Spacer()
                Spacer()
                Spacer()
            }
            .padding(20)
            .tint(Color.alwaysLight)
        }
    }
}

#Preview {
    MenuView(continueGameAction: {}, newGameAction: {}, loadScoreboardAction: { [ScoreData]() })
}
