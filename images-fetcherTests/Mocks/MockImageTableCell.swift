//
//  MockImageTableCell.swift
//  images-fetcherTests
//
//  Created by Youssef on 07/04/2023.
//

@testable import images_fetcher

class MockImageTableCell: ImageTableCellProtocol {

    var imageURL: String?
    var authorName: String?

    func configure(imageURL: String, authorName: String) {
        self.imageURL = imageURL
        self.authorName = authorName
    }
}
