//
//  ImagesListingSceneConfigurator.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import Foundation

class ImagesListingSceneConfigurator {

    static func configure() -> ImagesListingViewController {
        let presenter = ImagesListingPresenterImpl()
        let vc = ImagesListingViewController(presenter: presenter)
        presenter.attachView(viewDelegate: vc)
        return vc
    }
}
