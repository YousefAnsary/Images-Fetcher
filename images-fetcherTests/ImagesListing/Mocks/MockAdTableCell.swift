//
//  MockAdTableCell.swift
//  images-fetcherTests
//
//  Created by Youssef on 07/04/2023.
//

@testable import images_fetcher

class MockAdTableCell: AdTableCellProtocol {

    var title: String?

    func configure(title: String) {
        self.title = title
    }
}
