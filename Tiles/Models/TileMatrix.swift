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
        return self.matrix.reduce([], +)
    }

    // MARK: - Initialiser
    init(_ size: Int = 4) {
        self.size = size

        self.matrix = [[Tile]]()
        for _ in 0..<size {
            var row = [Tile]()
            for _ in 0..<size {
                row += [Tile()]
            }
            self.matrix += [row]
        }
    }
}
