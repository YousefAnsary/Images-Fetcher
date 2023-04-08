//
//  MockImagesGateway.swift
//  images-fetcherTests
//
//  Created by Youssef on 08/04/2023.
//

@testable import images_fetcher

class MockImagesGateway: ImagesGateway {
    var fetchImagesCalled = false
    var fetchImagesPage: Int?
    var fetchImagesPageSize: Int?
    var fetchImagesResult: Result<[ImageModel], Error>?
    
    func fetchImages(page: Int, pageSize: Int) async throws -> [ImageModel] {
        fetchImagesCalled = true
        fetchImagesPage = page
        fetchImagesPageSize = pageSize
        
        switch fetchImagesResult {
        case .success(let images):
            return images
        case .failure(let error):
            throw error
        case .none:
            fatalError("fetchImagesResult not set")
        }
    }
}
