//
//  NewsFilter.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import Foundation

struct NewsFilter {
    // MARK: - Properties

    static let defaultFilter = NewsFilter()

    var country: NewsCountry
    var category: NewsCategory
    var keyword: String?

    // MARK: - Init

    init(
        country: NewsCountry = .unitedStates,
        category: NewsCategory = .general,
        keyword: String? = nil
    ) {
        self.country = country
        self.category = category
        self.keyword = keyword
    }

    // MARK: - Methods

    func getActiveFiltersDescription() -> [NewsFilterDescription] {
        var filterDescriptions: [NewsFilterDescription] = []
        if country != Self.defaultFilter.country {
            filterDescriptions.append(
                .init(keyType: .country, value: country.rawValue)
            )
        }
        if category != Self.defaultFilter.category {
            filterDescriptions.append(
                .init(keyType: .category, value: category.rawValue)
            )
        }
        if let keyword, keyword != "" {
            filterDescriptions.append(
                .init(keyType: .keyword, value: keyword)
            )
        }
        return filterDescriptions
    }
}

struct NewsFilterDescription: Identifiable {
    let keyType: NewsFilterKeyType
    let value: String
    var id: String { keyType.id }
}

enum NewsFilterKeyType: Identifiable {
    case country
    case category
    case keyword

    var description: String {
        switch self {
        case .country: "Country"
        case .category: "Category"
        case .keyword: "Keyword"
        }
    }

    var id: String { description }
}

enum NewsCategory: String, Encodable, CaseIterable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}

enum NewsCountry: String, Encodable, CaseIterable {
    case unitedStates = "us"
}
