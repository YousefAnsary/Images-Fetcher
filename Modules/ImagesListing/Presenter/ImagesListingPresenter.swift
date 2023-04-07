//
//  ImagesListingPresenter.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import Foundation

protocol ImagesListingPresenter {
    func viewDidLoad()
    func getNumberOfSections() -> Int
    func getNumberOfRows(inSection section: Int) -> Int
    func shouldDequeueAdCell(atIndexPath indexPath: IndexPath) -> Bool
    func configureCell(_ cell: AdTableCellProtocol, indexPath: IndexPath)
    func configureCell(_ cell: ImageTableCellProtocol, indexPath: IndexPath)
    func willDisplayItem(atIndexPath indexPath: IndexPath)
}
