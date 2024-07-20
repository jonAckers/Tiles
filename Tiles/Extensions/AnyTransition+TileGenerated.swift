//
//  AnyTransition+TileGenerated.swift
//  Tiles
//
//  Created by Jon Ackers on 20/07/2024.
//

import SwiftUI

extension AnyTransition {
    static func tileGenerated(from: Edge, position: CGPoint, in: CGRect) -> AnyTransition {
        let anchor = UnitPoint(x: position.x / `in`.width, y: position.y / `in`.height)

        return AnyTransition.asymmetric(
            insertion: AnyTransition.opacity.combined(with: .move(edge: from)),
            removal: AnyTransition.opacity.combined(with: .modifier(
                active: Merged(
                    first: AnchoredScale(scaleFactor: 0.8, anchor: anchor),
                    second: BlurEffect(radius: 50)
                ),
                identity: Merged(
                    first: AnchoredScale(scaleFactor: 1, anchor: anchor),
                    second: BlurEffect(radius: 0)
                )
            ))
        )
    }
}
