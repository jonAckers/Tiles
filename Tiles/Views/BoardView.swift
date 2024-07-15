//
//  BoardView.swift
//  Tiles
//
//  Created by Jon Ackers on 14/07/2024.
//

import SwiftUI

struct BoardView: View {

    // MARK: - Properties
    let backgroundColor = Color(red: 0.26, green:0.32, blue: 0.27, opacity: 1)
    let backgroundBoard: [Tile]

    let board: TileMatrix
    var columns: [GridItem]

    // MARK: - Initialiser
    init(_ board: TileMatrix) {
        self.board = board
        columns = Array(repeating: GridItem(.flexible()), count: board.size)

        let numTiles = board.size * board.size
        backgroundBoard = (0..<numTiles).map { _ in Tile() }
    }

    // MARK: - Conformance to View Protocol
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Create background tiles
                LazyVGrid(columns: columns) {
                    ForEach(backgroundBoard, id:\.self.id) { tile in
                        TileView(tile)
                    }
                }
                .padding(10)

                // Create moveable tiles
                LazyVGrid(columns: columns) {
                    ForEach(board.flatMatrix, id:\.self.id) { tile in
                        TileView(tile)
                    }
                }
                .padding(10)
            }
        }
        .background {
            Color(backgroundColor)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .aspectRatio(contentMode: .fit)
        .cornerRadius(5)
    }
}

#Preview {
    BoardView(TileMatrix())
}
