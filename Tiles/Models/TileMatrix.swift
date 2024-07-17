//
//  TileMatrix.swift
//  Tiles
//
//  Created by Jon Ackers on 14/07/2024.
//

import Foundation

typealias Index = (Int, Int)

class TileMatrix: ObservableObject {
    // MARK: - Properties

    let size: Int
    @Published private(set) var matrix: [[Tile?]]

    // MARK: - Computed Properties

    var flatMatrix: [Tile?] {
        return matrix.reduce([], +)
    }

    // MARK: - Initialiser

    init(_ size: Int = 4) {
        self.size = size

        matrix = [[Tile]]()
        for _ in 0 ..< size {
            var row = [Tile?]()
            for _ in 0 ..< size {
                row += [nil]
            }
            matrix += [row]
        }
    }

    // MARK: - Methods

    subscript(index: Index) -> Tile? {
        if index.0 >= size && index.1 >= size {
            return nil
        }

        return matrix[index.1][index.0]
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

        // Pick random value for tile with 80% chance of 2, 20% chance of 4.
        let value = (0 ..< 5).randomElement()! == 0 ? 4 : 2

        // Create the new tile.
        matrix[idx.1][idx.0] = Tile(value)

        return true
    }
}
