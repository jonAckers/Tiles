//
//  Tile.swift
//  Tiles
//
//  Created by Jon Ackers on 14/07/2024.
//

import SwiftUI

typealias TileColor = (background: Color, font: Color)

struct Tile: Equatable, Identifiable {
    // MARK: - Static Properties

    private static let colors: [TileColor] = [
        /*     2 */ (Color.tile2, Color.alwaysDark),
        /*     4 */ (Color.tile4, Color.alwaysDark),
        /*     8 */ (Color.tile8, Color.alwaysLight),
        /*    16 */ (Color.tile16, Color.alwaysLight),
        /*    32 */ (Color.tile32, Color.alwaysLight),
        /*    64 */ (Color.tile64, Color.alwaysLight),
        /*   128 */ (Color.tile128, Color.alwaysLight),
        /*   256 */ (Color.tile256, Color.alwaysLight),
        /*   512 */ (Color.tile512, Color.alwaysLight),
        /*  1024 */ (Color.tile1024, Color.alwaysLight),
        /*  2048 */ (Color.tile2048, Color.alwaysLight),
        /*  4096 */ (Color.tile4096, Color.alwaysLight),
        /*  8192 */ (Color.tile8192, Color.alwaysLight),
        /* 16384 */ (Color.tile16384, Color.alwaysLight),
    ]

    // MARK: - Properties

    let id = UUID()
    var value: Int

    // MARK: - Computed Properties

    var backgroundColor: Color {
        return getColor().background
    }

    var fontColor: Color {
        return getColor().font
    }

    // MARK: - Initialiser

    private init() {
        value = 0
    }

    init(_ value: Int) {
        self.value = value
    }

    // MARK: - Static Methods

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value
    }

    static func getRandomTile() -> Tile {
        // Pick random value for tile with 80% chance of 2, 20% chance of 4.
        let value = (0 ..< 5).randomElement()! == 0 ? 4 : 2
        return Tile(value)
    }

    // MARK: - Private Methods

    private func getColor() -> TileColor {
        guard value > 0 else { return (Color.tileEmpty, Color.tileEmpty) }

        let idx = Int(log2(Double(value))) - 1

        guard idx < Tile.colors.count else {
            return (Color.black, Color.white)
        }

        return Tile.colors[idx]
    }
}

#if DEBUG
    extension Tile: CustomStringConvertible {
        public var description: String {
            return "\(value)"
        }
    }
#endif
