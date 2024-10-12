//
//  NewsListViewModel.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import Foundation

struct NewsFilter {
    let country: String?
    let category: HeadlineRequest.Category?

    init(country: String = "US", category: HeadlineRequest.Category? = nil) {
        self.country = country
        self.category = category
    }
}

final class NewsListViewModel: ObservableObject {
    @Published var headlines: [Headline] = []
    @Published var error: Error?
    private var currentPage = 1
    private let pageSize = 20
    var isLoading = false
    var hasNextPage = false
    private var filter: NewsFilter = .init()

    private let service: NewsServiceProtocol

    init(service: NewsServiceProtocol) {
        self.service = service
    }

    func fetchTopHeadlines() async {
        isLoading = true
        let headlines = await makeHeadlinesRequest(page: 0)
        DispatchQueue.main.async { [weak self] in
            self?.headlines = headlines
            self?.isLoading = false
        }
    }

    private func makeHeadlinesRequest(page: Int) async -> [Headline] {
        do {
            let request = HeadlineRequest(
                country: filter.country,
                category: filter.category,
                pageSize: pageSize,
                page: page
            )
            let response = try await service.fetchTopHeadlines(request)
            hasNextPage = response.totalResults > currentPage * pageSize
            return response.headlines.filterRemoved()
        } catch {
            DispatchQueue.main.async { [weak self] in
                print(error)
                self?.error = error
            }
            return []
        }
    }

    func loadMoreIfNeeded(currentItem: Headline) {
        let lastItemHasAppeared = currentItem.id == headlines.last?.id
        let shouldLoadMore = !isLoading && hasNextPage && lastItemHasAppeared
        if shouldLoadMore {
            isLoading = true
            currentPage += 1
            Task {
                let newHeadlines = await makeHeadlinesRequest(page: currentPage)
                DispatchQueue.main.async { [weak self] in
                    self?.headlines.append(contentsOf: newHeadlines)
                    self?.isLoading = false
                }
            }
        }
    }
}

extension Array where Element == Headline {
    func filterRemoved() -> [Headline] {
        filter { headline in
            !headline.title.contains("Removed")
        }
    }
}
