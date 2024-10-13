//
//  HeadlineRequest.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import Alamofire
import Foundation

struct HeadlineRequest: Encodable {
    let country: NewsCountry?
    let category: NewsCategory?
    let sources: String?
    let query: String?
    let pageSize: Int?
    let page: Int?

    init(
        country: NewsCountry? = nil,
        category: NewsCategory? = nil,
        sources: String? = nil,
        query: String? = nil,
        pageSize: Int? = nil,
        page: Int? = nil
    ) {
        self.country = country
        self.category = category
        self.sources = sources
        self.query = query
        self.pageSize = pageSize
        self.page = page
    }

    enum CodingKeys: String, CodingKey {
        case country
        case category
        case sources
        case query = "q"
        case pageSize
        case page
    }

    func toParameters() -> Parameters? {
        let decoder = JSONEncoder()
        guard let data = try? decoder.encode(self) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Parameters
    }
}
