//
//  TileMatrix.swift
//  Tiles
//
//  Created by Jon Ackers on 14/07/2024.
//

import Foundation

struct TileMatrix {

    // MARK: - Properties
    let size: Int
    private(set) var matrix: [[Tile]]

    // MARK: - Computed Properties
    var flatMatrix: [Tile] {
        return matrix.reduce([], +)
    }

    // MARK: - Initialiser
    init(_ size: Int = 4) {
        self.size = size

        matrix = [[Tile]]()
        for _ in 0..<size {
            var row = [Tile]()
            for _ in 0..<size {
                row += [Tile()]
            }
            matrix += [row]
        }
    }

    // MARK: - Methods
    func createTile() -> Bool {
        // Get empty tiles.
        let emptyTiles = flatMatrix.filter { $0.value == nil }

        // Exit if there is no space for a new tile.
        guard emptyTiles.count > 0 else { return false }

        // Pick random tile.
        let tile = emptyTiles.randomElement()!

        // Pick random value for tile with 80% chance of 2, 20% chance of 4.
        tile.value = (0..<5).randomElement()! == 0 ? 4 : 2

        return true
    }
}
