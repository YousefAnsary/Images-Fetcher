//
//  ImagesUseCaseTests.swift
//  images-fetcherTests
//
//  Created by Youssef on 08/04/2023.
//

import XCTest
@testable import images_fetcher

class ImagesUseCaseImplTests: XCTestCase {
    
    private var sut: ImagesUseCaseImpl!
    private var mockImagesGateway: MockImagesGateway!
    private var mockImagesLocalDataSource: MockImagesLocalDataSource!
    
    override func setUp() {
        super.setUp()
        mockImagesGateway = MockImagesGateway()
        mockImagesLocalDataSource = MockImagesLocalDataSource()
        sut = ImagesUseCaseImpl(imagesGateway: mockImagesGateway,
                                imagesLocalDataSource: mockImagesLocalDataSource)
    }
    
    override func tearDown() {
        sut = nil
        mockImagesGateway = nil
        mockImagesLocalDataSource = nil
        super.tearDown()
    }
    
    func testFetchImages_success() async throws {
        // given
        let expectedImages = [ImageModel(id: "1"),
                              ImageModel(id: "2")]
        mockImagesGateway.fetchImagesResult = .success(expectedImages)
        
        // when
        let result = try await sut.fetchImages()
        
        // then
        XCTAssertTrue(result.count == expectedImages.count)
        XCTAssertEqual(result[0].id, expectedImages[0].id)
        XCTAssertEqual(result[1].id, expectedImages[1].id)
    }
    
    func testFetchImages_gatewayError() async throws {
        // given
        let expectedImages = [ImageModel(id: "3"),
                              ImageModel(id: "4")]
        mockImagesGateway.fetchImagesResult = .failure(UnknownError())
        mockImagesLocalDataSource.fetchImagesResult = .success(expectedImages)
        
        // when
        let result = try await sut.fetchImages()
        
        // then
        XCTAssertTrue(result.count == expectedImages.count)
        XCTAssertEqual(result[0].id, expectedImages[0].id)
        XCTAssertEqual(result[1].id, expectedImages[1].id)
    }
}
