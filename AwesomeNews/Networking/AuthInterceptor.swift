//
//  AuthInterceptor.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import Alamofire
import Foundation

class AuthInterceptor: RequestInterceptor {
    static var apiKey: String {
        guard let key = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("API_KEY not set in Info.plist")
        }
        return key
    }

    init() {}

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var request = urlRequest
        request.setValue(Self.apiKey, forHTTPHeaderField: "X-Api-Key")
        completion(.success(request))
    }
}
