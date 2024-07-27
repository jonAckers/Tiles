//
//  TileView.swift
//  Tiles
//
//  Created by Jon Ackers on 14/07/2024.
//

import SwiftUI

struct TileView: View {
    // MARK: - Properties

    let tile: Tile?

    // MARK: - Computed Properties

    var backgroundColor: Color {
        guard let tile = tile else {
            return Tile.emptyColor
        }
        return tile.backgroundColor
    }

    var fontColor: Color {
        guard let tile = tile else {
            return Tile.emptyColor
        }
        return tile.fontColor
    }

    var number: String {
        guard let tile = tile else {
            return ""
        }

        return "\(tile.value)"
    }

    // MARK: - Initialisers

    private init() {
        tile = nil
    }

    init(_ tile: Tile?) {
        self.tile = tile
    }

    // MARK: - Conformance to View Protocol

    var body: some View {
        ZStack {
            Color(backgroundColor)
                .aspectRatio(contentMode: .fit)

            Text(number)
                .font(.system(size: 42,
                              weight: .bold,
                              design: .monospaced))
                .foregroundColor(fontColor)
                .minimumScaleFactor(0.01)
                .padding(5)
                .id(tile?.value)
                .transition(
                    AnyTransition
                        .scale(scale: 0.2)
                        .combined(with: .opacity)
                        .animation(.spring(response: 0.5, dampingFraction: 0.777, blendDuration: 0.3))
                )
        }
        .clipped()
        .cornerRadius(5)
    }

    // MARK: - Static Methods

    static func empty() -> Self {
        return self.init()
    }
}

#Preview {
    List {
        TileView.empty()
            .frame(width: 100, height: 100)
            .aspectRatio(contentMode: .fit)

        ForEach(1 ... 14, id: \.self) { v in
            let val = NSDecimalNumber(decimal: pow(2, v))
            TileView(Tile(Int(truncating: val)))
                .frame(width: 80, height: 80)
        }
    }
}
