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

    // MARK: - Initializers
    init(presenter: ImagesListingPresenter) {
        self.presenter = presenter
        super.init(nibName: "ImagesListingViewController", bundle: nil)
    }

    required init?(presenter: ImagesListingPresenter, coder: NSCoder) {
        self.presenter = presenter
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("Use the other init to provide View Model")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.attachView(viewDelegate: self)
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
}
