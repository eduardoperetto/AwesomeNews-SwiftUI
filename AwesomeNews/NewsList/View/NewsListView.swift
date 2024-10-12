//
//  ContentView.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import SwiftUI

struct NewsListView: View {
    @EnvironmentObject private var viewModel: NewsListViewModel

    var body: some View {
        NavigationView {
                    List {
                        ForEach(viewModel.headlines) { headline in
                            HeadlineRow(headline: headline, onAppear: {
                                viewModel.loadMoreIfNeeded(currentItem: headline)
                            })
                            .listRowInsets(EdgeInsets())
                            .padding(.vertical, 4)
                        }

                        if viewModel.isLoading && viewModel.headlines.count > 0 {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    }
                    .listStyle(PlainListStyle()) // Use plain list style for better aesthetics
                    .navigationTitle("Top Headlines")
                    .task {
                        await viewModel.fetchTopHeadlines()
                    }
                    .refreshable {
                        await viewModel.fetchTopHeadlines()
                    }
                }
            }
        }

#Preview {
    NewsListView()
        .environmentObject(
            NewsListViewModel(service: NewsService.shared)
        )
}
