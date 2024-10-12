//
//  NewsService.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import Alamofire
import Foundation

class NewsService: NewsServiceProtocol {
    // MARK: - Singleton Init

    static let shared = NewsService()

    private init() {
        let config = URLSessionConfiguration.default
        config.httpShouldSetCookies = true
        config.timeoutIntervalForRequest = 30
        session = Session(
            configuration: config,
            interceptor: AuthInterceptor(),
            eventMonitors: [NetworkLogger()]
        )
    }

    // MARK: - Properties

    private let baseUrl = "https://newsapi.org/"
    private let session: Session

    // MARK: - Generic Fetch

    private func fetch<T: Decodable>(
        _ endpoint: NewsAPI,
        with parameters: Parameters? = nil
    ) async throws -> T {
        let url = baseUrl + endpoint.path
        let dataTask = session.request(url, method: endpoint.method, parameters: parameters)
            .validate()
            .serializingDecodable(T.self, decoder: NewsAPIDecoder())
        let response = try await dataTask.value

        return response
    }

    // MARK: - API Methods

    func fetchTopHeadlines(_ request: HeadlineRequest) async throws -> HeadlineResponse {
        let endpoint = NewsAPI.topHeadlines
        return try await fetch(endpoint, with: request.toParameters())
    }
}

enum NewsAPI {
    case topHeadlines

    var path: String {
        switch self {
        case .topHeadlines: return "v2/top-headlines"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .topHeadlines: return .get
        }
    }
}
