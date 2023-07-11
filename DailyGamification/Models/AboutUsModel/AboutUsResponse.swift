//
//  AboutUsResponse.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 11/07/2023.
//

import Foundation

struct AboutUsResponse: Codable {
    var items: [AboutUsItem]
}

struct AboutUsItem: Codable {
    var date: Date
    var title: String
    var description: String
    var author: String
    var image: String
    var content: String
}

var aboutUsItem  = AboutUsItem(
    date: Date(),
    title: "About us",
    description: "Here is about us page",
    author: "Dariusz Tarczyński",
    image: "https://dariusztarczynski.com/static/img/screenshot-2023-03-18-at-19.50.57.png",
    content: "<h2>We are the software &amp; gamification experts @ TDSOFT</h2>\n<p>About tdsoft</p>\n<h2>We gamify office culture @ OGAMIFY</h2>\n<p>RAbout tdsoft</p>\n<h2>We teach and share @ &quot;Real-Life Gamification&quot; book</h2>\n<p>RAbout tdsoft</p>\n<h2>We want you to grow @ this app!</h2>\n<p>RAbout tdsoft</p>\n"
)
