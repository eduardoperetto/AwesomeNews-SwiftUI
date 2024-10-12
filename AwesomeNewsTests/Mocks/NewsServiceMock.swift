//
//  NewsServiceMock.swift
//  AwesomeNewsTests
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

@testable import AwesomeNews
import Foundation

open class NewsServiceMock: NewsServiceProtocol {
    var onFetchTopHeadlines: ((HeadlineRequest) async throws -> HeadlineResponse) = { _ in
        fatalError("Not implemented")
    }

    public func fetchTopHeadlines(_ request: HeadlineRequest) async throws -> HeadlineResponse {
        return try await onFetchTopHeadlines(request)
    }
}
