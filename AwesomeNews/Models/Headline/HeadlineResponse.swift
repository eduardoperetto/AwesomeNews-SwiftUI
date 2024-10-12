//
//  HeadlineResponse.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import Foundation

struct HeadlineResponse {
    let status: Status
    let totalResults: Int
    let headlines: [Headline]
    let code: String?
    let message: String?

    enum Status: String, Codable {
        case ok
        case error
    }
}

// MARK: - Decodable

extension HeadlineResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
        case code
        case message
    }

    /// Custom initializer to handle conditional decoding based on status.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Status.self, forKey: .status)

        if status == .ok {
            totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
            headlines = try container.decodeIfPresent([Headline].self, forKey: .articles) ?? []
            code = nil
            message = nil
        } else {
            totalResults = 0
            headlines = []
            code = try container.decodeIfPresent(String.self, forKey: .code)
            message = try container.decodeIfPresent(String.self, forKey: .message)
        }
    }
}

