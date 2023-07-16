//
//  PrimaryButton.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 16/07/2023.
//

import SwiftUI

struct PrimaryButton: View {
    var title: String
    var imageSystemName: String
    var backgroundColor: Color
    var buttonAction: () -> Void
    var body: some View {
        Button(action: buttonAction) {
            HStack {
                Image(systemName: imageSystemName)
                    .foregroundColor(.white)
                Text(title)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(backgroundColor)
        .shadow(radius: 5)
        .cornerRadius(5)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(
            title: "Add Counter",
            imageSystemName: "arrow.counterclockwise.circle", backgroundColor: .purple, buttonAction: {}
        )
    }
}
