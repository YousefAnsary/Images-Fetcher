//
//  ImagesUseCase.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

protocol ImagesUseCase {
    var hasMoreData: Bool { get }
    func fetchImages() async throws -> [ImageModel]
    func loadMoreImages() async throws -> [ImageModel]
}

class ImagesUseCaseImpl: ImagesUseCase {

    private let imagesGateway: ImagesGateway
    private let imagesLocalDataSource: ImagesLocalDataSource
    private let pageSize = 10
    private var images = [ImageModel]()
    private var currentPage = 1
    private(set) var hasMoreData = false
    private var didLoadFromLocal = false

    init(imagesGateway: ImagesGateway = ImagesGatewayImpl(),
         imagesLocalDataSource: ImagesLocalDataSource = ImagesLocalDataSourceImpl()) {
        self.imagesGateway = imagesGateway
        self.imagesLocalDataSource = imagesLocalDataSource
    }

    func fetchImages() async throws -> [ImageModel] {
        self.currentPage = 0
        self.images = []
        self.hasMoreData = true
        return try await self.loadMoreImages()
    }

    func loadMoreImages() async throws -> [ImageModel] {
        guard self.hasMoreData else { return self.images }
        self.currentPage += 1
        let images = try await self.fetchImages(page: self.currentPage, pageSize: self.pageSize)
        self.images += images
        self.hasMoreData = images.count == self.pageSize && !self.didLoadFromLocal
        self.saveFirst20()
        return self.images
    }

    private func fetchImages(page: Int, pageSize: Int) async throws -> [ImageModel] {
        do {
            let images = try await self.imagesGateway.fetchImages(page: currentPage, pageSize: pageSize)
            self.didLoadFromLocal = false
            return images
        } catch {
            let images = try self.imagesLocalDataSource.fetchImages()
            self.didLoadFromLocal = true
            return images
        }
    }

    private func saveFirst20() {
        guard self.images.count <= 20 else { return }
        DispatchQueue.global(qos: .background).async {
            self.imagesLocalDataSource.deleteAllImages()
            try? self.imagesLocalDataSource.saveImages(self.images)
        }
    }
}
