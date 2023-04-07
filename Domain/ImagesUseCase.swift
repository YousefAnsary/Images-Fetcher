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
    private let pageSize = 10
    private var images = [ImageModel]()
    private var currentPage = 1
    private(set) var hasMoreData = false

    init(imagesGateway: ImagesGateway = ImagesGatewayImpl()) {
        self.imagesGateway = imagesGateway
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
        self.hasMoreData = images.count == self.pageSize
        return self.images
    }

    private func fetchImages(page: Int, pageSize: Int) async throws -> [ImageModel] {
        return try await self.imagesGateway.fetchImages(page: currentPage, pageSize: pageSize)
    }
}
