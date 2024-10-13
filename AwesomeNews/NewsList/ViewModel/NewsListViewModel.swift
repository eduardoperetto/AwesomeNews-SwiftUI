//
//  NewsListViewModel.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import Foundation

final class NewsListViewModel: ObservableObject {
    // MARK: - Published properties

    @Published var headlines: [Headline] = []
    @Published var error: Error?
    @Published var isLoading = false
    @Published var presentFilterSheet = true
    @Published var hasReachedEnd = false
    @Published var filter: NewsFilter = .init()

    // MARK: - Properties

    private var currentPage = 1
    private let pageSize = 20

    var hasNextPage = false

    private let service: NewsServiceProtocol

    init(service: NewsServiceProtocol) {
        self.service = service
    }

    func fetchTopHeadlines() async {
        isLoading = true
        currentPage = 1
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
                query: filter.keyword,
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
        } else {
            hasReachedEnd = true
        }
    }

    func applyFilters(category: NewsCategory, country: NewsCountry, keyword: String) {
        presentFilterSheet = false
        filter = NewsFilter(country: country, category: category, keyword: keyword)
        Task { await fetchTopHeadlines() }
    }

    func resetFilters() {
        filter = NewsFilter.defaultFilter
        Task { await fetchTopHeadlines() }
    }

    func resetFilter(_ keyType: NewsFilterKeyType) {
        switch keyType {
        case .category:
            filter.category = NewsFilter.defaultFilter.category
        case .country:
            filter.country = NewsFilter.defaultFilter.country
        case .keyword:
            filter.keyword = NewsFilter.defaultFilter.keyword
        }
        Task { await fetchTopHeadlines() }
    }
}

extension Array where Element == Headline {
    func filterRemoved() -> [Headline] {
        filter { headline in
            !headline.title.contains("Removed")
        }
    }
}
