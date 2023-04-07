//
//  ImageDetailsSceneConfigurator.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import UIKit.UIImage

class ImageDetailsSceneConfigurator {

    static func configure(image: UIImage) -> ImageDetailsViewController {
        let presenter = ImageDetailsPresenterImpl(image: image)
        let vc = ImageDetailsViewController(presenter: presenter)
        presenter.attachView(viewDelegate: vc)
        return vc
    }
}
