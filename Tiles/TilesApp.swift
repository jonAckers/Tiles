//
//  TilesApp.swift
//  Tiles
//
//  Created by Jon Ackers on 14/07/2024.
//

import SwiftUI

@main
struct TilesApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.secondaryAccent
                    .ignoresSafeArea()

                CompositeView()
            }
        }
    }
}
