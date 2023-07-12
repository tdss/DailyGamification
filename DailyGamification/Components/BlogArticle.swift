//
//  BlogArticleItem.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 10/07/2023.
//

import SwiftUI

struct BlogArticle: View {
    @Environment(\.colorScheme) var colorScheme
    var blogArticleItem: BlogArticleItem

    var body: some View {
        VStack(alignment: .leading) {
//            AsyncImage(url: URL(string: blogArticleItem.image)) { image in
//                image
//                    .resizable()
//                    .frame(height: 250)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
//            } placeholder: {
//                Color.gray
//            }
//            .frame(height: 250)
//            .padding(.vertical, 6)

            HStack(alignment: .center) {
                Text("\(blogArticleItem.title)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .black : .primary)
                    .padding(.top, 5)
                Spacer()
                Image(systemName: "chevron.forward.circle")
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }

            HStack {
                Text("Author: \(blogArticleItem.author)")
                    .font(.caption)
                    .foregroundColor(colorScheme == .dark ? .gray : .secondary)
            }
            .padding(.top, 2)

            Text("\(blogArticleItem.description)")
                .font(.body)
                .foregroundColor(colorScheme == .dark ? .black : .primary)
                .lineLimit(4)
                .padding(.top, 5)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            .white
        )
        .cornerRadius(10)
        .shadow(color: colorScheme == .dark ? .white : .gray, radius: 2, x: 0, y: 2)
    }
}



let blogArticleItem = BlogArticleItem(
    date: Date(),
    title: "Track your personal goals with a help of gamification",
    description: "Gamification can help you define and stick to your life goals. You only need to understand a few core principles",
    author: "Dariusz Tarczyński",
    image: "https://dariusztarczynski.com/static/img/1676288871657.jpg",
    content: "Content"
)

struct BlogArticle_Previews: PreviewProvider {
    static var previews: some View {
        BlogArticle(blogArticleItem: blogArticleItem)
    }
}
