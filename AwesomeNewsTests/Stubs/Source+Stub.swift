//
//  Source+Stub.swift
//  AwesomeNewsTests
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import Foundation
@testable import AwesomeNews

extension Headline.Source {
    static func stub(
        id: String = "id",
        name: String = "name"
    ) -> Self {
        return .init(id: id, name: name)
    }
}
