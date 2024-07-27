//
//  TilesApp.swift
//  Tiles
//
//  Created by Jon Ackers on 14/07/2024.
//

import SwiftUI

@main
struct TilesApp: App {
    // MARK: - Properties

    let backgroundColor = Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)

    var body: some Scene {
        WindowGroup {
            ZStack {
                Color(backgroundColor)
                    .ignoresSafeArea()

                CompositeView()
            }
        }
    }
}
