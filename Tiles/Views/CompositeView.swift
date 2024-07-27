//
//  CompositeView.swift
//  Tiles
//
//  Created by Jon Ackers on 27/07/2024.
//

import SwiftUI

struct CompositeView: View {
    // MARK: - Properties

    @ObservedObject var board = TileMatrix()
    @State private var isShowingMenu = false

    // MARK: - Conformance to View Protocol

    var body: some View {
        if isShowingMenu {
            MenuView(
                continueGameAction: continueGame,
                newGameAction: newGame,
                loadScoreboardAction: board.loadScoreboard
            )
        } else {
            GameView(board, $isShowingMenu)
        }
    }

    // MARK: - Private Methods

    private func continueGame() {
        isShowingMenu = false
    }

    private func newGame() {
        board.reset()
        isShowingMenu = false
    }
}

#Preview {
    CompositeView()
}
