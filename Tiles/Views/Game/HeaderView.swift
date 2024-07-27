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
    let lightColor = Color(red: 0.96, green: 1.00, blue: 0.96, opacity: 1)
    let greenColor = Color(red: 0.48, green: 0.70, blue: 0.48, opacity: 1)

    let score: Int

    @Binding var isShowingMenu: Bool

    // MARK: - Conformance to View Protocol

    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Tiles")
                    .font(.system(size: 64).weight(.black))
                    .foregroundStyle(darkColor)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                VStack {
                    Text("Score")
                        .font(.system(size: 22).weight(.black))
                        .foregroundStyle(lightColor.opacity(0.5))

                    Spacer()

                    Text("\(score)")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundStyle(lightColor)
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

            Button {
                withAnimation {
                    isShowingMenu.toggle()
                }
            } label: {
                Text("Menu")
                    .font(.system(size: 22).weight(.bold))
                    .frame(width: 90)
                    .padding(5)
                    .background(greenColor)
                    .cornerRadius(5)
            }
            .tint(lightColor)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    HeaderView(score: 1234, isShowingMenu: .constant(false))
}
