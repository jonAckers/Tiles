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
    @State private var ignoreGestures = false

    // MARK: - Drag Gesture

    private var dragGesture: some Gesture {
        let threshold: CGFloat = 25

        let drag = DragGesture()
            .onChanged { v in
                guard !ignoreGestures else { return }

                guard abs(v.translation.width) > threshold ||
                    abs(v.translation.height) > threshold
                else {
                    return
                }

                withTransaction(Transaction()) {
                    ignoreGestures = true

                    if v.translation.width < -threshold {
                        // Left
                        board.move(.left)
                    } else if v.translation.width > threshold {
                        // Right
                        board.move(.right)
                    } else if v.translation.height < -threshold {
                        // Up
                        board.move(.up)
                    } else if v.translation.height > threshold {
                        // Down
                        board.move(.down)
                    }
                }
            }
            .onEnded { _ in
                ignoreGestures = false
            }

        return drag
    }

    // MARK: - Initialiser

    init() {
        board = TileMatrix()
        board.createTile()
    }

    // MARK: - Conformance to View Protocol

    var body: some View {
        VStack {
            HeaderView(score: board.score)
                .frame(maxHeight: 100)

            Spacer()

            BoardView(board)
                .aspectRatio(contentMode: .fit)

            Spacer()
            Spacer()
        }
        .padding(15)
        .background(.white.opacity(0.01))
        .gesture(dragGesture)
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
