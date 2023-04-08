//
//  ImageModel.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

struct ImageModel: Codable {

    let id: String
    let author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
