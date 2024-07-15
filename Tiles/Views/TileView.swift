//
//  TileView.swift
//  Tiles
//
//  Created by Jon Ackers on 14/07/2024.
//

import SwiftUI

struct TileView: View {

    // MARK: - Properties
    let tile: Tile

    // MARK: - Initialiser
    init(_ tile: Tile) {
        self.tile = tile
    }

    // MARK: - Conformance to View Protocol
    var body: some View {
        ZStack {
            Color(tile.backgroundColor)
                .aspectRatio(contentMode: .fit)

            Text(tile.strValue)
                .font(.system(size: 42,
                              weight: .bold,
                              design: .monospaced))
                .foregroundColor(tile.fontColor)
                .minimumScaleFactor(0.01)
                .padding(5)
        }
        .zIndex(Double.greatestFiniteMagnitude)
        .clipped()
        .cornerRadius(5)
    }
}

#Preview {
    List {
        TileView(Tile())
            .frame(width: 100, height: 100)
            .aspectRatio(contentMode: .fit)

        ForEach((1...14), id:\.self) { v in
            let val = NSDecimalNumber(decimal: pow(2, v))
            TileView(Tile(Int(truncating: val)))
                .frame(width: 100, height: 100)
        }
    }
}
