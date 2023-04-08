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
        let router = ImagesListingRouterImpl()
        let vc = ImagesListingViewController(presenter: presenter,
                                             router: router)
        router.attachController(vc)
        presenter.attachView(viewDelegate: vc)
        return vc
    }
}
