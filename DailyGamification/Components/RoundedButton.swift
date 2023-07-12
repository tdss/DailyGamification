//
//  RoundedButton.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 06/07/2023.
//

import SwiftUI

struct RoundedButton: View {
    let systemImageName: String
    let buttonAction: () -> Void
    var body: some View {
        Button(action: buttonAction) {
            Image(systemName: systemImageName)
                .font(.callout)
                .foregroundColor(.gray)
                .frame(width: 50, height: 50)
                .background(.white)
                .cornerRadius(25)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(systemImageName: "plus", buttonAction: {
            print("Button Pressed")
        })
    }
}
