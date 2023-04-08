//
//  MockImagesListingViewDelegate.swift
//  images-fetcherTests
//
//  Created by Youssef on 07/04/2023.
//

@testable import images_fetcher

class MockImagesListingViewDelegate: ImagesListingViewDelegate {

    var reloadTableViewCalled = false
    var displayMessageCalled = false

    func reloadTableView() {
        reloadTableViewCalled = true
    }

    func displayMessage(withTitle title: String?, message: String, okAction: (() -> Void)?) {
        displayMessageCalled = true
    }
}
