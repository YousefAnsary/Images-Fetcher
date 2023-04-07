//
//  ImagesListingViewDelegate.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import Foundation

protocol ImagesListingViewDelegate: AnyObject {
    func displayMessage(withTitle title: String?,
                        message: String,
                        okAction: (() -> Void)?)
    func reloadTableView()
}
