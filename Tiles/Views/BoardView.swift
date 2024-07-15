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

    let board: TileMatrix
    var columns: [GridItem]

    // MARK: - Initialiser
    init(_ board: TileMatrix) {
        self.board = board
        self.columns = Array(repeating: GridItem(.flexible()), count: self.board.size)
    }

    // MARK: - Conformance to View Protocol
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                LazyVGrid(columns: self.columns) {
                    // Create background tiles
                    ForEach(self.board.flatMatrix, id:\.self.id) { tile in
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
