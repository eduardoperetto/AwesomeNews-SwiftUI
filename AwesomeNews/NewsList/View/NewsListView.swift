//
//  ContentView.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import SwiftUI

struct NewsListView: View {
    @EnvironmentObject private var viewModel: NewsListViewModel

    private var filterButton: some View {
        Button {
            viewModel.presentFilterSheet.toggle()
        } label: {
            Image(systemName: "line.horizontal.3.decrease.circle")
                .imageScale(.large)
                .foregroundStyle(.tint)
        }
    }

    private var progressView: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                NewsFilterChipStackView(
                    openFilterSheet: { viewModel.presentFilterSheet = true },
                    resetFilter: { filterKey in viewModel.resetFilter(filterKey) },
                    filterState: viewModel.filter
                )
                List {
                    ForEach(viewModel.headlines) { headline in
                        HeadlineRow(
                            headline: headline,
                            onAppear: { viewModel.loadMoreIfNeeded(currentItem: headline) }
                        )
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical, 4)
                    }

                    if viewModel.isLoading {
                        progressView
                    }
                    else if viewModel.hasReachedEnd {
                        Text("You're all caught up!")
                            .foregroundColor(.secondary)
                            .font(.caption)
                            .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Top Headlines")
            .task { await viewModel.fetchTopHeadlines() }
            .refreshable { await viewModel.fetchTopHeadlines() }
            .sheet(isPresented: $viewModel.presentFilterSheet) {
                NewsFilterView(viewModel: viewModel)
                    .presentationDetents([.medium, .large])
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
