//
//  ImagesListingViewController.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import UIKit

class ImagesListingViewController: UIViewController {

    // MARK: - IBOutlets & Variables
    @IBOutlet private weak var tableView: UITableView!
    //
    private let presenter: ImagesListingPresenter
    private let router: ImagesListingRouter

    // MARK: - Initializers
    init(presenter: ImagesListingPresenter,
         router: ImagesListingRouter) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: "ImagesListingViewController", bundle: nil)
    }

    required init?(presenter: ImagesListingPresenter,
                   router: ImagesListingRouter,
                   coder: NSCoder) {
        self.presenter = presenter
        self.router = router
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("Use the other init to provide presenter & router")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.setupTableView()
    }

    // MARK: - Private Functions
    private func setupTableView() {
        self.tableView.register(cellType: ImageTableCell.self)
        self.tableView.register(cellType: AdTableCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

// MARK: - View Delegate
extension ImagesListingViewController: ImagesListingViewDelegate {

    func displayMessage(withTitle title: String?,
                        message: String,
                        okAction: (() -> Void)?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: { _ in okAction?() })
        alertController.addAction(okAlertAction)
        self.present(alertController, animated: true)
    }

    func reloadTableView() {
        self.tableView.reloadData()
    }
}

// MARK: - UITableView Delegate & Data Source
extension  ImagesListingViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.getNumberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getNumberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // If it's an AD cell index, return the AD cell
        if self.presenter.shouldDequeueAdCell(atIndexPath: indexPath) {
            let cell: AdTableCell = tableView.dequeueReusableCell(for: indexPath)
            self.presenter.configureCell(cell, indexPath: indexPath)
            return cell
        } else {
            let cell: ImageTableCell = tableView.dequeueReusableCell(for: indexPath)
            self.presenter.configureCell(cell, indexPath: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.presenter.willDisplayItem(atIndexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ImageTableCell,
              let image = cell.getImage() else { return }
        self.router.presentImageDetails(image: image)
    }
}
