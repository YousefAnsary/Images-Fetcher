//
//  MockImagesUseCase.swift
//  images-fetcherTests
//
//  Created by Youssef on 07/04/2023.
//

@testable import images_fetcher

class MockImagesUseCase: ImagesUseCase {

    var fetchImagesCalled = false
    var loadMoreImagesCalled = false
    var fetchImagesReturnValue = [ImageModel]()
    var loadMoreImagesReturnValue = [ImageModel]()

    func fetchImages() async throws -> [ImageModel] {
        fetchImagesCalled = true
        return self.fetchImagesReturnValue
    }

    func loadMoreImages() async throws -> [ImageModel] {
        loadMoreImagesCalled = true
        return self.fetchImagesReturnValue + self.loadMoreImagesReturnValue
    }

    var hasMoreData: Bool = false
}
