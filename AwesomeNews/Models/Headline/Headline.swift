//
//  Headline.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import Foundation

struct Headline: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: URL
    let urlToImage: URL?
    let publishedAt: Date
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }

    struct Source: Codable {
        let id: String?
        let name: String
    }
}

extension Headline: Identifiable {
    var id: URL { url }
}

extension Headline: Equatable {
    static func == (lhs: Headline, rhs: Headline) -> Bool {
        lhs.id == rhs.id
    }
}
