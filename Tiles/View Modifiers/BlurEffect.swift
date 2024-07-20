//
//  BlurEffect.swift
//  Tiles
//
//  Created by Jon Ackers on 20/07/2024.
//

import SwiftUI

struct BlurEffect: ViewModifier {
    // MARK: - Properties

    let radius: CGFloat

    // MARK: - Conformance to ViewModifier

    func body(content: Self.Content) -> some View {
        content.blur(radius: radius)
    }
}
