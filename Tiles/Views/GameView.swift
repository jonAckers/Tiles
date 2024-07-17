//
//  GameView.swift
//  Tiles
//
//  Created by Jon Ackers on 14/07/2024.
//

import SwiftUI

struct GameView: View {
    // MARK: - Properties

    @ObservedObject var board: TileMatrix

    // MARK: - Initialiser

    init() {
        board = TileMatrix()
        board.createTile()
    }

    // MARK: - Conformance to View Protocol

    var body: some View {
        VStack {
            Text("Tiles")
                .font(.system(size: 64).weight(.black))
                .foregroundColor(Color(red: 0.19, green: 0.22, blue: 0.22, opacity: 1))
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            BoardView(board)
                .aspectRatio(contentMode: .fit)

            Spacer()
            Spacer()
        }
        .padding(15)
    }
}

#Preview {
    let backgroundColor = Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)

    return (
        ZStack {
            Color(backgroundColor)
                .ignoresSafeArea()

            GameView()
        }
    )
}
