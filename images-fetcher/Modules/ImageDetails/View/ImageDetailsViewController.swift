//
//  ImageDetailsViewController.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import UIKit

class ImageDetailsViewController: UIViewController {

    // MARK: - IBOutlets & Variables
    @IBOutlet private weak var imageView: UIImageView!
    //
    private let presenter: ImageDetailsPresenter

    // MARK: - Initializers
    init(presenter: ImageDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: "ImageDetailsViewController", bundle: nil)
    }

    required init?(presenter: ImageDetailsPresenter, coder: NSCoder) {
        self.presenter = presenter
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("Use the other init to provide presenter")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
}

// MARK: - View Delegate
extension ImageDetailsViewController: ImageDetailsViewDelegate {

    func displayImage(_ image: UIImage) {
        self.imageView.image = image
    }

    func setBackgroundColor(with color: UIColor) {
        self.view.backgroundColor = color
    }
}
