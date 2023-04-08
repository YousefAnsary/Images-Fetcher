//
//  ImageModel+Extensions.swift
//  images-fetcherTests
//
//  Created by Youssef on 07/04/2023.
//

@testable import images_fetcher

extension ImageModel {
    init(downloadURL: String, author: String) {
        self.init(id: "id",
                  author: author,
                  width: 0,
                  height: 0,
                  url: "url",
                  downloadURL: downloadURL)
    }
    
    init(id: String) {
        self.init(id: id,
                  author: "author",
                  width: 0,
                  height: 0,
                  url: "url",
                  downloadURL: "downloadURL")
    }
}
