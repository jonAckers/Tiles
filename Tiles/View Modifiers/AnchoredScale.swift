//
//  AnchoredScale.swift
//  Tiles
//
//  Created by Jon Ackers on 20/07/2024.
//

import SwiftUI

struct AnchoredScale: ViewModifier {
    // MARK: - Properties

    let scaleFactor: CGFloat
    let anchor: UnitPoint

    // MARK: - Conformance to ViewModifier

    func body(content: Self.Content) -> some View {
        content.scaleEffect(scaleFactor, anchor: anchor)
    }
}
