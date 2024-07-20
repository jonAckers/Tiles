//
//  HeaderView.swift
//  Tiles
//
//  Created by Jon Ackers on 20/07/2024.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - Properties

    let darkColor = Color(red: 0.19, green: 0.22, blue: 0.22, opacity: 1)

    let score: Int

    // MARK: - Conformance to View Protocol

    var body: some View {
        HStack {
            Text("Tiles")
                .font(.system(size: 64).weight(.black))
                .foregroundStyle(darkColor)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack {
                Text("Score")
                    .font(.system(size: 22).weight(.black))
                    .foregroundStyle(Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 0.5))

                Spacer()

                Text("\(score)")
                    .font(.system(size: 64, weight: .bold))
                    .foregroundStyle(Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1))
                    .minimumScaleFactor(0.01)
                    .contentTransition(.numericText())
                    .animation(.easeInOut(duration: 0.05), value: score)

                Spacer()
                Spacer()
            }
            .frame(width: 90, height: 90)
            .padding(5)
            .background(darkColor)
            .cornerRadius(5)
        }
    }
}

#Preview {
    HeaderView(score: 1234)
}
