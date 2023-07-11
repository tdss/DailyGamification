//
//  BlogArticleDetail.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 11/07/2023.
//

import SwiftUI
import RichText

struct BlogArticleDetail: View {
    @Environment(\.colorScheme) var colorScheme
    var blogArticle: BlogArticleItem
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    header
                    Text("\(blogArticle.title)")
                        .font(.title2)
                        .bold()
                        .padding(.vertical, 10)
                    HStack {
                        Text("Author: \(blogArticle.author)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(blogArticle.date.formatted())")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                    RichText(html: blogArticle.content)
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
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(colorScheme == .dark ? .white : .black)
    }
    
    var header: some View {
         VStack(alignment: .leading) {
             AsyncImage(url: URL(string: blogArticle.image)) { image in
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
     }
}


struct BlogArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        BlogArticleDetail(blogArticle: blogArticleItem)
    }
}
