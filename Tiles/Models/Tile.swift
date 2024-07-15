//
//  Tile.swift
//  Tiles
//
//  Created by Jon Ackers on 14/07/2024.
//

import SwiftUI

typealias TileColor = (background: Color, font: Color)

class Tile: Identifiable {

    // MARK: - Properties
    let id = UUID()
    var value: Int?

    private let colors: [TileColor] = [
       /*     0 */ (Color(red: 0.32, green: 0.39, blue: 0.33, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)),
       /*     2 */ (Color(red: 0.90, green: 0.94, blue: 0.90, opacity: 1), Color(red: 0.19, green: 0.22, blue: 0.22, opacity: 1)),
       /*     4 */ (Color(red: 0.72, green: 0.82, blue: 0.72, opacity: 1), Color(red: 0.19, green: 0.22, blue: 0.22, opacity: 1)),
       /*     8 */ (Color(red: 0.48, green: 0.70, blue: 0.48, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)),
       /*    16 */ (Color(red: 0.27, green: 0.51, blue: 0.27, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)),
       /*    32 */ (Color(red: 0.17, green: 0.43, blue: 0.17, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)),
       /*    64 */ (Color(red: 0.07, green: 0.44, blue: 0.07, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)),
       /*   128 */ (Color(red: 0.29, green: 0.48, blue: 0.73, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)),
       /*   256 */ (Color(red: 0.18, green: 0.36, blue: 0.69, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)),
       /*   512 */ (Color(red: 0.09, green: 0.28, blue: 0.52, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)),
       /*  1024 */ (Color(red: 0.02, green: 0.21, blue: 0.45, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)),
       /*  2048 */ (Color(red: 0.22, green: 0.09, blue: 0.52, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)),
       /*  4096 */ (Color(red: 0.61, green: 0.20, blue: 0.45, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)),
       /*  8192 */ (Color(red: 0.71, green: 0.25, blue: 0.11, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)),
       /* 16384 */ (Color(red: 0.67, green: 0.01, blue: 0.01, opacity: 1), Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1))
    ]


    // MARK: - Computed Properties
    var strValue: String {
        guard let value = self.value else { return "" }
        return String(value)
    }

    var backgroundColor: Color {
        return getColor().background
    }

    var fontColor: Color {
        return getColor().font
    }

    // MARK: - Initialiser
    init() {
        value = nil
    }

    init(_ value: Int) {
        self.value = value
    }

    // MARK: - Private Methods
    private func getColor() -> TileColor {
        guard let value = self.value else {
            return colors[0]
        }

        let idx = Int(log2(Double(value)))

        guard idx < colors.count else {
            return (Color.black, Color.white)
        }

        return colors[idx]
    }
}
