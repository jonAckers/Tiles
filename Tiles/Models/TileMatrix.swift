//
//  TileMatrix.swift
//  Tiles
//
//  Created by Jon Ackers on 14/07/2024.
//

import SwiftUI

typealias Index = (Int, Int)

class TileMatrix: ObservableObject {
    // MARK: - Properties

    let size: Int
    @Published private(set) var matrix = [[Tile?]]()
    @Published private(set) var lastMoveDir: Direction = .up
    @Published private(set) var score: Int = 0
    @Published private(set) var movePossible: Bool = true

    let defaults = UserDefaults.standard

    private let BOARD_KEY = "Board"
    private let SCORE_KEY = "Score"

    // MARK: - Initialiser

    init(_ size: Int = 4) {
        self.size = size

        let (matrix, score) = loadState()
        self.matrix = matrix
        self.score = score

        saveState()
    }

    // MARK: - Methods

    subscript(index: Index) -> Tile? {
        if index.0 >= size && index.1 >= size {
            return nil
        }

        return matrix[index.1][index.0]
    }

    func flatten() -> [IndexedTile] {
        matrix.enumerated().flatMap { (j: Int, row: [Tile?]) in
            row.enumerated().compactMap { (i: Int, tile: Tile?) in
                guard let tile = tile else {
                    return nil
                }
                return IndexedTile(index: (i, j), tile: tile)
            }
        }
    }

    func reset() {
        score = 0
        movePossible = true
        matrix = getStartingMatrix()

        saveState()
    }

    func move(_ direction: Direction) {
        var moved = false

        let axis = direction == .left || direction == .right
        let negativeDir = direction == .left || direction == .up

        for i in 0 ..< size {
            var lineSnapshot = [Tile?]()
            var compactLine = [Tile]()

            // Transpose if necessary.
            for j in 0 ..< size {
                if let tile = self[axis ? (j, i) : (i, j)] {
                    lineSnapshot.append(tile)
                    compactLine.append(tile)
                } else {
                    lineSnapshot.append(nil)
                }
            }

            // Merge tiles.
            merge(&compactLine, reverse: !negativeDir)

            // Create new line.
            var newLine = [Tile?]()
            compactLine.forEach { newLine.append($0) }
            for _ in 0 ..< (4 - compactLine.count) {
                if negativeDir {
                    newLine.append(nil)
                } else {
                    newLine.insert(nil, at: 0)
                }
            }

            // Add new line to matrix.
            newLine.enumerated().forEach { j, tile in
                // TODO: workout why it gets in here when the board hasn't changed
                if lineSnapshot[j]?.value != tile?.value {
                    moved = true
                }
                insert(tile, at: axis ? (j, i) : (i, j))
            }
        }

        // Create new tile if move occurred.
        if moved {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.035 * TimeInterval(size)) {
                self.createTile()
                self.movePossible = self.isMovePossible()
            }
        }
    }

    func isMovePossible() -> Bool {
        for (j, row) in matrix.enumerated() {
            for (i, tile) in row.enumerated() {
                // If there's an empty tile, move is possible.
                if tile == nil {
                    return true
                }
                // If the current tile has the same value as one of it's neighbours, move is possible.
                if i + 1 < size, tile == matrix[j][i + 1] {
                    return true
                }
                if i - 1 > -1, tile == matrix[j][i - 1] {
                    return true
                }
                if j + 1 < size, tile == matrix[j + 1][i] {
                    return true
                }
                if j - 1 > -1, tile == matrix[j - 1][i] {
                    return true
                }
            }
        }
        return false
    }

    // MARK: - Private Methods

    private func getStartingMatrix() -> [[Tile?]] {
        matrix = [[Tile]]()
        for _ in 0 ..< size {
            var row = [Tile?]()
            for _ in 0 ..< size {
                row += [nil]
            }
            matrix += [row]
        }

        let i = (0 ..< size).randomElement()!
        let j = (0 ..< size).randomElement()!
        matrix[i][j] = Tile.getRandomTile()

        return matrix
    }

    @discardableResult
    func createTile() -> Bool {
        // Get empty tiles.
        var emptyTiles = [Index]()
        for i in 0 ..< size {
            for j in 0 ..< size {
                if self[(i, j)] == nil {
                    emptyTiles.append((i, j))
                }
            }
        }

        // Exit if there is no space for a new tile.
        guard emptyTiles.count > 0 else { return false }

        // Pick random tile.
        let idx = emptyTiles.randomElement()!

        // Create the new tile.
        matrix[idx.1][idx.0] = Tile.getRandomTile()

        // Save new state of TileMatrix.
        saveState()

        return true
    }

    private func merge(_ tiles: inout [Tile], reverse: Bool) {
        if reverse {
            tiles = tiles.reversed()
        }

        tiles = tiles
            .map { (false, $0) }
            .reduce([(Bool, Tile)]()) { acc, tile in
                if acc.last?.0 == false && acc.last?.1.value == tile.1.value {
                    var accPrefix = Array(acc.dropLast())
                    var mergedTile = tile.1
                    mergedTile.value *= 2
                    score += mergedTile.value
                    accPrefix.append((true, mergedTile))
                    return accPrefix
                } else {
                    var accTmp = acc
                    accTmp.append((false, tile.1))
                    return accTmp
                }
            }
            .map { $0.1 }

        if reverse {
            tiles = tiles.reversed()
        }
    }

    private func insert(_ tile: Tile?, at: Index) {
        matrix[at.1][at.0] = tile
    }

    private func saveState() {
        // Convert tile matrix into integer matrix.
        let replica: [[Int]] = matrix.map { row in
            row.map { tile in
                tile?.value ?? 0
            }
        }

        // Save data.
        defaults.set(replica, forKey: BOARD_KEY)
        defaults.set(score, forKey: SCORE_KEY)
    }

    private func loadState() -> ([[Tile?]], Int) {
        // Load data.
        let data = defaults.object(forKey: BOARD_KEY) as? [[Int]]

        // If data doesn't exist, return empty matrix.
        guard let replica = data else { return (getStartingMatrix(), 0) }

        // Convert loaded data to a Tile matrix.
        matrix = [[Tile]]()
        for i in 0 ..< replica.count {
            var row = [Tile?]()
            for j in 0 ..< replica[0].count {
                if replica[i][j] == 0 {
                    row.append(nil)
                } else {
                    row.append(Tile(replica[i][j]))
                }
            }
            matrix += [row]
        }

        // Load score.
        let score = defaults.object(forKey: SCORE_KEY) as? Int ?? 0

        return (matrix, score)
    }
}
