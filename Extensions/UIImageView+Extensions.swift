//
//  UIImageView+Extensions.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import UIKit
import SDWebImage

extension UIImageView {

    func loadImage(fromURL urlString: String, placeholderImageName: String? = nil) {
        let urlStringWithoutSpacing = urlString.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: urlStringWithoutSpacing)
        let placeholder = UIImage(named: placeholderImageName ?? "")
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_imageTransition = SDWebImageTransition.fade
        self.sd_setImage(with: url, placeholderImage: placeholder)
    }
}
