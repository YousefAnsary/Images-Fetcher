//
//  ImagesListingRouter.swift
//  images-fetcher
//
//  Created by Youssef on 08/04/2023.
//

import UIKit

protocol ImagesListingRouter {
    func presentImageDetails(image: UIImage)
}

class ImagesListingRouterImpl: ImagesListingRouter {

    private weak var controller: UIViewController!

    func attachController(_ controller: UIViewController) {
        self.controller = controller
    }

    func presentImageDetails(image: UIImage) {
        let detailsVC = ImageDetailsSceneConfigurator.configure(image: image)
        controller.present(detailsVC, animated: true)
    }
}
