//
//  AwesomeNewsApp.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import SwiftUI

@main
struct AwesomeNewsApp: App {
    var body: some Scene {
        WindowGroup {
            NewsListView()
                .environmentObject(
                    NewsListViewModel(service: NewsService.shared)
                )
        }
    }
}
