//
//  Merged.swift
//  Tiles
//
//  Created by Jon Ackers on 20/07/2024.
//

import SwiftUI

struct Merged<M1, M2>: ViewModifier where M1: ViewModifier, M2: ViewModifier {
    // MARK: - Properties

    let m1: M1
    let m2: M2

    // MARK: - Initialiser

    init(first: M1, second: M2) {
        m1 = first
        m2 = second
    }

    // MARK: - Conformance to ViewModifier

    func body(content: Self.Content) -> some View {
        content.modifier(m1).modifier(m2)
    }
}
