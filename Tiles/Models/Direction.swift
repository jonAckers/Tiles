//
//  Direction.swift
//  Tiles
//
//  Created by Jon Ackers on 17/07/2024.
//

import SwiftUI

enum Direction {
    case left, right, up, down

    var edge: Edge {
        switch self {
        case .left:
            return .leading
        case .right:
            return .trailing
        case .up:
            return .top
        case .down:
            return .bottom
        }
    }

    var invertedEdge: Edge {
        switch edge {
        case .leading:
            return .trailing
        case .trailing:
            return .leading
        case .top:
            return .bottom
        case .bottom:
            return .top
        }
    }
}
