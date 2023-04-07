//
//  ImagesListingPresenterImpl.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import Foundation

class ImagesListingPresenterImpl: ImagesListingPresenter {

    // MARK: - Variables
    private let imagesUseCase: ImagesUseCase
    private var items = [ImageModel]()
    private var isLoading = false
    //
    private weak var viewDelegate: ImagesListingViewDelegate?

    // MARK: - Initializers
    init(imagesUseCase: ImagesUseCase = ImagesUseCaseImpl()) {
        self.imagesUseCase = imagesUseCase
    }

    // MARK: - Public Functions
    func attachView(viewDelegate: ImagesListingViewDelegate) {
        self.viewDelegate = viewDelegate
    }

    func viewDidLoad() {
        Task {
            await self.fetchImages(paginating: false)
        }
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

    func configureCell(_ cell: AdTableCellProtocol, indexPath: IndexPath) {
        cell.configure(title: "Ad Separator \(indexPath.row)")
    }

    func configureCell(_ cell: ImageTableCellProtocol, indexPath: IndexPath) {
        let item = self.items[indexPath.row - (indexPath.row / 6)]
        cell.configure(imageURL: item.downloadURL, authorName: item.author)
    }

    func willDisplayItem(atIndexPath indexPath: IndexPath) {
        let itemsCount = self.getNumberOfRows(inSection: indexPath.section)
        guard indexPath.row == itemsCount - 1 &&
                !isLoading &&
                self.imagesUseCase.hasMoreData else {
            return
        }
        Task {
            await self.fetchImages(paginating: true)
        }
    }

    // MARK: - Private Functions
    private func fetchImages(paginating: Bool) async {
        self.isLoading = true
        let fetcher = self.imagesUseCase.fetchImages
        let paginator = self.imagesUseCase.loadMoreImages
        let function = paginating ? paginator : fetcher
        do {
            let images = try await function()
            self.items = images
            await self.reloadTable()
        } catch {
            await self.handleError(error)
        }
        self.isLoading = false
    }

    @MainActor
    private func reloadTable() {
        self.viewDelegate?.reloadTableView()
    }

    @MainActor
    private func handleError(_ error: Error) {
        self.viewDelegate?.displayMessage(withTitle: "Error",
                                          message: "Something went wrong",
                                          okAction: nil)
    }
}
