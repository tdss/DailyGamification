//
//  AboutUsView.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 11/07/2023.
//

import SwiftUI
import RichText

struct AboutUsView: View {
    var aboutUsItem: AboutUsItem
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: aboutUsItem.image)) { image in
                    image
                        .resizable()
                        .frame(width: .infinity)
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: .infinity, height: 250)
                .padding(.vertical, 6)
            }
            .frame(maxWidth: .infinity)
            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
            RichText(html: aboutUsItem.content)
                .lineHeight(130)
                .colorScheme(.auto)
                .imageRadius(12)
                .fontType(.system)
                .foregroundColor(light: Color.primary, dark: Color.white)
                .linkColor(light: Color.blue, dark: Color.blue)
                .colorPreference(forceColor: .onlyLinks)
                .linkOpenType(.SFSafariView())
                .customCSS("")
                .placeholder {
                    VStack {
                        Spacer()
                        ProgressView()
                            .scaleEffect(1.2)
                        Spacer()
                    }
                    .frame(height: 200)
                }
                .transition(.easeOut)
                .padding()
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView(aboutUsItem: aboutUsItem)
    }
}
