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
            GeometryReader { geo in
                List {
                    header
                        .listRowSeparator(.hidden)
                    switch blogModel.loadingState {
                    case .loading:
                        Loader()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .listRowSeparator(.hidden)
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
            Text("Blog")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .padding(.bottom, 10)
                
                
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean auctor ex libero, eu pulvinar massa.")
                .font(.body)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                .padding(.bottom, 10)
        }
        .background(colorScheme == .dark ? .black : .white)
    }
}

struct BlogView_Previews: PreviewProvider {
    static var previews: some View {
        BlogView()
    }
}
