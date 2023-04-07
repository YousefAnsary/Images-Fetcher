//
//  ImageDetailsPresenterImpl.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import UIKit.UIImage
import UIKit.UIColor

class ImageDetailsPresenterImpl: ImageDetailsPresenter {

    // MARK: - Variables
    private let image: UIImage
    //
    private weak var viewDelegate: ImageDetailsViewDelegate?

    // MARK: - Initializers
    init(image: UIImage) {
        self.image = image
    }

    func attachView(viewDelegate: ImageDetailsViewDelegate) {
        self.viewDelegate = viewDelegate
    }

    // MARK: - Public Functions
    func viewDidLoad() {
        self.bindData()
    }

    // MARK: - Private Functions
    private func bindData() {
        self.viewDelegate?.displayImage(self.image)
        DispatchQueue.global(qos: .userInteractive).async {
            let dominantColor = self.image.extractDominantColor()
            self.setBackgroundColor(dominantColor)
        }
    }

    private func setBackgroundColor(_ color: UIColor) {
        DispatchQueue.main.async {
            self.viewDelegate?.setBackgroundColor(with: color)
        }
    }
}
