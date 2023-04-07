//
//  ImagesGateway.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import Foundation

protocol ImagesGateway {
    func fetchImages(page: Int, pageSize: Int) async throws -> [ImageModel]
}

class ImagesGatewayImpl: ImagesGateway {

    private let apiClient: APIClient

    init(apiClient: APIClient = APIClientImpl()) {
        self.apiClient = apiClient
    }

    func fetchImages(page: Int, pageSize: Int) async throws -> [ImageModel] {
        return try await self.apiClient.get(url: "https://picsum.photos/v2/list?page=\(page)&limit=\(pageSize)")
    }
}
