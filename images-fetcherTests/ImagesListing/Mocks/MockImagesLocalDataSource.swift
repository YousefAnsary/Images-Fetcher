//
//  MockImagesLocalDataSource.swift
//  images-fetcherTests
//
//  Created by Youssef on 08/04/2023.
//

@testable import images_fetcher

class MockImagesLocalDataSource: ImagesLocalDataSource {
    var saveImagesCalled = false
    var saveImagesInputImages: [ImageModel]?
    var fetchImagesCalled = false
    var fetchImagesResult: Result<[ImageModel], Error>?
    var deleteAllImagesCalled = false
    
    func saveImages(_ images: [ImageModel]) throws {
        saveImagesCalled = true
        saveImagesInputImages = images
    }
    
    func fetchImages() throws -> [ImageModel] {
        fetchImagesCalled = true
        
        switch fetchImagesResult {
        case .success(let images):
            return images
        case .failure(let error):
            throw error
        case .none:
            fatalError("fetchImagesResult not set")
        }
    }
    
    func deleteAllImages() {
        deleteAllImagesCalled = true
    }
}
