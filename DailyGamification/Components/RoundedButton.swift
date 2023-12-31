//
//  RoundedButton.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 06/07/2023.
//

import SwiftUI

struct RoundedButton: View {
    @Environment(\.colorScheme) var colorScheme
    let systemImageName: String
    let buttonAction: () -> Void
    var body: some View {
        Button(action: buttonAction) {
            Image(systemName: systemImageName)
                .font(.callout)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .frame(width: 50, height: 50)
                .background(colorScheme == .dark ? .black : .white)
                .cornerRadius(25)
                .shadow(color: colorScheme == .dark ? Color("Primary").opacity(0.8) : .black.opacity(0.2), radius: 10, x: -1,  y: 12)
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
