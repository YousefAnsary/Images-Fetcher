//
//  ImageDetailsViewDelegate.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import UIKit.UIImage
import UIKit.UIColor

protocol ImageDetailsViewDelegate: AnyObject {
    func displayImage(_ image: UIImage)
    func setBackgroundColor(with color: UIColor)
}
