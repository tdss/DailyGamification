//
//  BlogArticleItem.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 10/07/2023.
//

import Foundation

struct BlogResponse: Codable {
    var items: [BlogArticleItem]
}

struct BlogArticleItem: Codable {
    var date: Date
    var title: String
    var description: String
    var author: String
    var image: String
    var content: String
}
