//
//  BlogModel.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 10/07/2023.
//

import Foundation

enum BlogError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

class BlogModel: ObservableObject {
    @Published var blogArticles: [BlogArticleItem] = []
    @Published var hasError: Bool = false
    @Published var loadingState: LoadingState = .idle
    
    enum LoadingState {
        case idle
        case loading
        case refreshing
    }
    
    private let urlString = "https://dariusztarczynski.com/personal-gamification-blog.json"
    
    func fetch() async {
    
        do {
            DispatchQueue.main.async {
                self.loadingState = self.blogArticles.isEmpty ? .loading : .refreshing
            }
            guard let url = URL(string: urlString) else {
                throw BlogError.invalidURL
            }
            
            let request = URLRequest(url: url)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw BlogError.invalidResponse
            }
            
            let entriesCardsData = try decodeData(data)
            DispatchQueue.main.async {
                self.updateUI(with: entriesCardsData)
            }
        } catch {
            print(error)
            DispatchQueue.main.async {
                self.loadingState = .idle
                self.hasError = true
            }
        }
    }
    
    private func decodeData(_ data: Data) throws -> [BlogArticleItem] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        // Support for fractional seconds
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            if let date = dateFormatter.date(from: dateString) {
                return date
            }
            
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Invalid date: \(dateString)")
        }
        let blogResponse = try decoder.decode(BlogResponse.self, from: data)
        return blogResponse.items.map { blogArticle in
            BlogArticleItem(
                id: UUID(),
                date: blogArticle.date,
                title: blogArticle.title,
                description: blogArticle.description,
                author: blogArticle.author,
                image: blogArticle.image,
                content: blogArticle.content
            )
        }
    }

    
    private func updateUI(with blogArticles: [BlogArticleItem]) {
        self.blogArticles = blogArticles
        self.loadingState = .idle
    }
}
