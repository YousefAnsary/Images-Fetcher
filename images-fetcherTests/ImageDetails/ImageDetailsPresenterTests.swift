//
//  ImageDetailsPresenterTests.swift
//  images-fetcherTests
//
//  Created by Youssef on 08/04/2023.
//

import XCTest
@testable import images_fetcher

class ImageDetailsPresenterTests: XCTestCase {

    // MARK: - Variables
    private var presenter: ImageDetailsPresenterImpl!
    private var mockViewDelegate: MockImageDetailsViewDelegate!
    private let mockColor = UIColor.red

    // MARK: - Set Up & Tear Down
    override func setUp() {
        super.setUp()
        let mockImage = UIImage.from(color: mockColor)!
        presenter = ImageDetailsPresenterImpl(image: mockImage)
        mockViewDelegate = MockImageDetailsViewDelegate()
    }

    override func tearDown() {
        presenter = nil
        mockViewDelegate = nil
        super.tearDown()
    }

    // MARK: - Tests
    func testBindData() async throws {
        // Given
        presenter.attachView(viewDelegate: mockViewDelegate)

        // When
        presenter.viewDidLoad()
        try await Task.sleep(nanoseconds: 1_000_000_000)

        // Then
        XCTAssertTrue(mockViewDelegate.displayImageCalled, "Expected to call displayImage() method")
        XCTAssertTrue(mockViewDelegate.setBackgroundColorCalled, "Expected to call setBackgroundColor() method")
        XCTAssertEqual(mockViewDelegate.backgroundColor, mockColor, "Expected to set background color to the dominant color")
    }

}
