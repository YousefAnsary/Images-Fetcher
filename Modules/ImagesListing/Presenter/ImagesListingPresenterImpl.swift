//
//  ImagesListingPresenterImpl.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import Foundation

class ImagesListingPresenterImpl: ImagesListingPresenter {

    private var items = [String]()
    private var currentPage = 1
    private var pageSize = 10
    private var isLoading = false

    func viewDidLoad() {
        
    }
    
    func getNumberOfSections() -> Int {
        return 1
    }

    func getNumberOfRows(inSection section: Int) -> Int {
        let itemsCount = self.items.count
        return itemsCount + (itemsCount / 5)
    }

    func shouldDequeueAdCell(atIndexPath indexPath: IndexPath) -> Bool {
        return indexPath.row % 6 == 5
    }

    func configureCell(_ cell: AdTableCellProtocol, indexPath: IndexPath) {}

    func configureCell(_ cell: ImageTableCellProtocol, indexPath: IndexPath) {
        let item = self.items[indexPath.row - (indexPath.row / 6)]
    }

    func willDisplayItem(atIndexPath indexPath: IndexPath) {
        let itemsCount = self.getNumberOfRows(inSection: indexPath.section)
        if indexPath.row == itemsCount - 1 && !isLoading {
            currentPage += 1
            fetchItems(page: currentPage)
        }
    }
}
