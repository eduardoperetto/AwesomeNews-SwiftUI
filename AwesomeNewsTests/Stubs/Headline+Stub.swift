//
//  Headline+Stub.swift
//  AwesomeNewsTests
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

@testable import AwesomeNews
import Foundation

extension Headline {
    static func stub(
        source: Source = .stub(),
        author: String? = "Author",
        title: String = "Title",
        description: String? = "Description",
        url: URL = URL(string: "https://www.example.com")!,
        urlToImage: URL? = URL(string: "https://www.example.com/image.jpg"),
        publishedAt: Date = Date(),
        content: String? = "Content"
    ) -> Self {
        .init(
            source: source,
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content
        )
    }
}
