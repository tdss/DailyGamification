//
//  BlogView.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 07/07/2023.
//

import SwiftUI

struct BlogView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var blogModel: BlogModel = BlogModel()
    
    var body: some View {
        NavigationView {
            VStack {
                header
                List {
                    switch blogModel.loadingState {
                    case .loading:
                        Text("loading")
                    case .idle, .refreshing:
                        ForEach(blogModel.blogArticles, id: \.id) { blogArticleItem in
                            ZStack {
                                NavigationLink(destination: BlogArticleDetail(blogArticle: blogArticleItem)) {
                                    EmptyView()
                                }
                                BlogArticle(blogArticleItem: blogArticleItem)
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                }
                .listStyle(.inset)
                .task {
                    await blogModel.fetch()
                }
                .refreshable {
                    print(blogModel.$blogArticles)
                    await blogModel.fetch()
                }
                .background(Color.white)
            }
        }
    }
    
    var header: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Blog")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.purple)
                    .padding(.bottom, 10)
                
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean auctor ex libero, eu pulvinar massa.")
                    .font(.body)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                    .padding(.bottom, 10)
            }
            .padding(.leading, 10)
            .padding(.bottom, 10)
            
        }
        .frame(maxWidth: .infinity)
        .background(  colorScheme == .dark ?
                      LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing) :
                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.white]), startPoint: .leading, endPoint: .trailing))
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

var blogArticlesItems: [BlogArticleItem] = [
    BlogArticleItem(
        date: Date(),
        title: "Track your personal goals with a help of gamification",
        description: "Gamification can help you define and stick to your life goals. You only need to understand a few core principles",
        author: "Dariusz Tarczyński",
        image: "https://dariusztarczynski.com/static/img/1676288871657.jpg",
        content: "Content"
    ),
    BlogArticleItem(
        date: Date(),
        title: "Rewards do not always work. See some examples.",
        description:  "Introducing rewards ewerywhere is tempting, but sometimes they may do more harm than good. Lets see where they make the most sense",
        author: "Dariusz Tarczyński",
        image: "https://dariusztarczynski.com/static/img/egor-myznik-drs9xsnlazw-unsplash.jpg",
        content: "Content2"
    ),
    BlogArticleItem(
        date: Date(),
        title: "Personal Growht Secrets (based on behavioral science)",
        description: "If you ever wanted to change or improve but never got anywhere, then this article will open your eyes.",
        author: "Dariusz Tarczyński",
        image: "https://dariusztarczynski.com/static/img/brave_e441fabesk.png",
        content: "Content3"
    ),
]

struct BlogView_Previews: PreviewProvider {
    static var previews: some View {
        BlogView()
    }
}
