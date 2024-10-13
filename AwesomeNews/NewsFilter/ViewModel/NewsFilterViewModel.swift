//
//  NewsFilterViewModel.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import Foundation
import SwiftUI

final class NewsFilterViewModel: ObservableObject {
    @Published var filter: NewsFilter

    init(filter: NewsFilter) {
        self.filter = filter
    }
}
