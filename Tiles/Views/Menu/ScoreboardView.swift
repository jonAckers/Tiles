//
//  ScoreboardView.swift
//  Tiles
//
//  Created by Jon Ackers on 27/07/2024.
//

import SwiftUI

struct ScoreData: Codable, Identifiable {
    var id = UUID()
    let score: Int
    let highestTile: Int
    let date: Date
    let boardSize: Int
}

struct ScoreboardView: View {
    // MARK: - Properties

    @Environment(\.dismiss) private var dismiss

    let darkColor = Color(red: 0.19, green: 0.22, blue: 0.22, opacity: 1)

    let scoreboard: [ScoreData]
    let dateFormatter: DateFormatter
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    init(_ scoreboard: [ScoreData]) {
        self.scoreboard = scoreboard

        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
    }

    // MARK: - Conformance to View Protocol

    var body: some View {
        VStack {
            VStack {
                Button {
                    dismiss()

                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                }
                .tint(Color(red: 0.27, green: 0.51, blue: 0.27, opacity: 1))
                .frame(maxWidth: .infinity, alignment: .leading)

                Text("Scoreboard")
                    .font(.system(size: 42).weight(.black))
                    .foregroundStyle(darkColor)
                    .frame(maxWidth: .infinity)
            }

            ScrollView {
                LazyVGrid(columns: columns) {
                    Group {
                        Text("Date")
                            .font(.system(size: 22).weight(.heavy))

                        Text("Score")
                            .font(.system(size: 22).weight(.heavy))

                        Text("Board Size")
                            .font(.system(size: 22).weight(.heavy))
                            .multilineTextAlignment(.center)

                        Text("Max Tile")
                            .font(.system(size: 22).weight(.heavy))
                            .multilineTextAlignment(.center)
                    }

                    ForEach(scoreboard) { row in
                        Text(dateFormatter.string(from: row.date))
                            .font(.system(size: 18).weight(.semibold))
                            .multilineTextAlignment(.center)

                        Text("\(row.score)")
                            .font(.system(size: 18).weight(.semibold))

                        Text("\(row.boardSize)x\(row.boardSize)")
                            .font(.system(size: 18).weight(.semibold))

                        TileView(Tile(row.highestTile))
                            .frame(width: 70, height: 70)
                    }
                }
                .foregroundStyle(darkColor)
            }

            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    let mockScores: [ScoreData] = [
        ScoreData(score: 871_291, highestTile: 2048, date: Date.now, boardSize: 5),
        ScoreData(score: 124, highestTile: 64, date: Date.now, boardSize: 4),
        ScoreData(score: 123, highestTile: 32, date: Date.now, boardSize: 4),
        ScoreData(score: 2, highestTile: 2, date: Date.now, boardSize: 4),
    ]

    return ScoreboardView(mockScores)
}
