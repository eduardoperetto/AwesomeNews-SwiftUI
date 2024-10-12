//
//  NewsListViewModelTests.swift
//  AwesomeNewsTests
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

@testable import AwesomeNews
import Foundation
import XCTest

class NewsListViewModelTests: XCTest {
    // MARK: - Configs

    typealias Sut = NewsListViewModel
    private var sut: Sut!
    private var serviceMock = NewsServiceMock() {
        didSet {
            sut = .init(service: serviceMock)
        }
    }

    override func setUp() {
        serviceMock = .init()
    }

    override func tearDown() {}

    // MARK: - Tests

    func test_fetchTopHeadlines_whenServiceReturnsError_shouldSetError() async {
        // Given
        let error = NSError(domain: "test", code: 0, userInfo: nil)
        serviceMock.onFetchTopHeadlines = { _ in throw error }

        // When
        await sut.fetchTopHeadlines()

        // Then
        XCTAssertEqual(sut.error as NSError?, error)
    }

    func test_fetchTopHeadlines_whenServiceReturnsHeadlines_shouldSetHeadlines() async {
        // Given
        let headlines = [Headline.stub()]
        serviceMock.onFetchTopHeadlines = { _ in
            .init(
                status: .ok,
                totalResults: headlines.count,
                headlines: headlines,
                code: nil,
                message: nil
            )
        }

        // When
        await sut.fetchTopHeadlines()

        // Then
        XCTAssertEqual(sut.headlines, headlines)
    }
}
