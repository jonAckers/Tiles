//
//  HeaderView.swift
//  Tiles
//
//  Created by Jon Ackers on 20/07/2024.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - Properties

    let score: Int

    @Binding var isShowingMenu: Bool

    // MARK: - Conformance to View Protocol

    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Tiles")
                    .font(.system(size: 64).weight(.black))
                    .foregroundStyle(Color.primaryAccent)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                VStack {
                    Text("Score")
                        .font(.system(size: 22).weight(.black))
                        .foregroundStyle(Color.secondaryAccent.opacity(0.5))

                    Spacer()

                    Text("\(score)")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundStyle(Color.secondaryAccent)
                        .minimumScaleFactor(0.01)
                        .contentTransition(.numericText())
                        .animation(.easeInOut(duration: 0.05), value: score)

                    Spacer()
                    Spacer()
                }
                .frame(width: 90, height: 90)
                .padding(5)
                .background(Color.primaryAccent)
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
                    .background(Color.tile8)
                    .cornerRadius(5)
            }
            .tint(Color.alwaysLight)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    HeaderView(score: 1234, isShowingMenu: .constant(false))
}
