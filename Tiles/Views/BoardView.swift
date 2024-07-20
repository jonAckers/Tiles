//
//  BoardView.swift
//  Tiles
//
//  Created by Jon Ackers on 14/07/2024.
//

import SwiftUI

struct BoardView: View {
    // MARK: - Properties

    let backgroundColor = Color(red: 0.26, green: 0.32, blue: 0.27, opacity: 1)

    let board: TileMatrix
    var columns: [GridItem]

    // MARK: - Initialiser

    init(_ board: TileMatrix) {
        self.board = board
        columns = Array(repeating: GridItem(.flexible()), count: board.size)
    }

    // MARK: - Conformance to View Protocol

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Create background tiles
                ForEach(0 ..< board.size, id: \.self) { i in
                    ForEach(0 ..< board.size, id: \.self) { j in
                        createTile(nil, at: (i, j), proxy: proxy)
                    }
                }

                // Create moveable tiles
                ForEach(board.flatten(), id: \.tile.id) { item in
                    createTile(item.tile, at: item.index, proxy: proxy)
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

    // MARK: - Private Methods

    private func createTile(_ tile: Tile?, at index: Index, proxy: GeometryProxy) -> some View {
        var view = TileView.empty()
        if tile != nil {
            view = TileView(tile)
        }

        let spacing = calculateTileSpacing(proxy)
        let tileSize = calculateTileSize(proxy, padding: spacing)
        let frameSize = calculateFrameSize(proxy)

        let position = CGPoint(
            x: CGFloat(index.0) * (tileSize + spacing) + tileSize / 2 + spacing,
            y: CGFloat(index.1) * (tileSize + spacing) + tileSize / 2 + spacing
        )

        return view
            .frame(width: tileSize, height: tileSize, alignment: .center)
            .position(x: position.x, y: position.y)
            .transition(.tileGenerated(
                from: board.lastMoveDir.edge,
                position: CGPoint(x: position.x, y: position.y),
                in: CGRect(x: 0, y: 0, width: frameSize, height: frameSize)
            ))
            .animation(
                .interpolatingSpring(stiffness: 800, damping: 200),
                value: position
            )
    }

    private func calculateTileSize(_ proxy: GeometryProxy, padding: CGFloat) -> CGFloat {
        let boardSize = CGFloat(board.size)
        return (proxy.size.width / boardSize) - (padding + padding / boardSize)
    }

    private func calculateTileSpacing(_ proxy: GeometryProxy) -> CGFloat {
        return (proxy.size.width / 300) * 8 // Create 8 pixels of spacing for every 300 pixels of tile
    }

    private func calculateFrameSize(_ proxy: GeometryProxy) -> CGFloat {
        let padding = proxy.size.width / 10
        return proxy.size.width - padding
    }
}

#Preview {
    BoardView(TileMatrix())
}
