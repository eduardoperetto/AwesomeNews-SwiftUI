//
//  NewsServiceProtocol.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchTopHeadlines(_ request: HeadlineRequest) async throws -> HeadlineResponse
}
