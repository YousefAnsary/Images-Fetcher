//
//  ImagesLocalDataSource.swift
//  images-fetcher
//
//  Created by Youssef on 08/04/2023.
//

import Foundation

protocol ImagesLocalDataSource {
    func saveImages(_ images: [ImageModel]) throws
    func fetchImages() throws -> [ImageModel]
    func deleteAllImages()
}

class ImagesLocalDataSourceImpl: ImagesLocalDataSource {

    private let fileManager: DataFileManager
    private let fileName = "images_fetcher_images_list"

    init(fileManager: DataFileManager = .sharedInstance()) {
        self.fileManager = fileManager
    }

    func saveImages(_ images: [ImageModel]) throws {
        let data = try JSONEncoder().encode(images)
        self.fileManager.save(data, withName: self.fileName)
    }

    func fetchImages() throws -> [ImageModel] {
        guard let data = self.fileManager.getDataWithName(self.fileName) else { return [] }
        return try JSONDecoder().decode([ImageModel].self, from: data)
    }

    func deleteAllImages() {
        self.fileManager.removeFile(withName: self.fileName)
    }
}
