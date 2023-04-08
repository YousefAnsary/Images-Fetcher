//
//  ImagesListingPresenterImplTests.swift
//  images-fetcherTests
//
//  Created by Youssef on 07/04/2023.
//

import XCTest
@testable import images_fetcher

final class ImagesListingPresenterTests: XCTestCase {

    // MARK: - Variables
    private var presenter: ImagesListingPresenterImpl!
    private var viewDelegate: MockImagesListingViewDelegate!
    private var useCase: MockImagesUseCase!

    // MARK: - Setup and teardown
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewDelegate = MockImagesListingViewDelegate()
        useCase = MockImagesUseCase()
        presenter = ImagesListingPresenterImpl(imagesUseCase: useCase)
        presenter.attachView(viewDelegate: viewDelegate)
    }

    override func tearDownWithError() throws {
        presenter = nil
        viewDelegate = nil
        useCase = nil
        try super.tearDownWithError()
    }

    // MARK: - Tests
    func testViewDidLoad() async throws {
        // Given
        let images = [ImageModel(downloadURL: "url1", author: "author1")]
        useCase.fetchImagesReturnValue = images

        // When
        presenter.viewDidLoad()
        try await Task.sleep(nanoseconds: 1_000_000)

        // Then
        XCTAssertTrue(viewDelegate.reloadTableViewCalled)
        XCTAssertEqual(presenter.getNumberOfRows(inSection: 0), images.count)
    }

    func testWillDisplayItem() async throws {
        // Given
        let images = [ImageModel(downloadURL: "url1", author: "author1")]
        useCase.hasMoreData = true
        useCase.fetchImagesReturnValue = images
        useCase.loadMoreImagesReturnValue = images
        presenter.viewDidLoad()
        try await Task.sleep(nanoseconds: 1_000_000)

        // When
        presenter.willDisplayItem(atIndexPath: IndexPath(row: presenter.getNumberOfRows(inSection: 0) - 1, section: 0))
        try await Task.sleep(nanoseconds: 1_000_000)

        // Then
        XCTAssertTrue(viewDelegate.reloadTableViewCalled)
        XCTAssertEqual(presenter.getNumberOfRows(inSection: 0), images.count * 2)
    }

    func testShouldDequeueAdCell() throws {
        XCTAssertTrue(presenter.shouldDequeueAdCell(atIndexPath: IndexPath(row: 5, section: 0)))
        XCTAssertFalse(presenter.shouldDequeueAdCell(atIndexPath: IndexPath(row: 4, section: 0)))
    }

    func testConfigureAdCell() {
        // Given
        let cell = MockAdTableCell()
        let indexPath = IndexPath(row: 5, section: 0)

        // When
        presenter.configureCell(cell, indexPath: indexPath)

        // Then
        XCTAssertEqual(cell.title, "Ad Separator \(indexPath.row)")
    }

    func testConfigureImageCell() async throws {
        // Given
        let cell = MockImageTableCell()
        let indexPath = IndexPath(row: 0, section: 0)
        let item = ImageModel(downloadURL: "url1", author: "author1")
        useCase.fetchImagesReturnValue = [item]
        presenter.viewDidLoad()
        try await Task.sleep(nanoseconds: 1_000_000)

        // When
        presenter.configureCell(cell, indexPath: indexPath)

        // Then
        XCTAssertEqual(cell.imageURL, item.downloadURL)
        XCTAssertEqual(cell.authorName, item.author)
    }
}
