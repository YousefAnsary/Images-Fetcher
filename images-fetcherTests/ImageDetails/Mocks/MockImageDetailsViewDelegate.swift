//
//  MockImageDetailsViewDelegate.swift
//  images-fetcherTests
//
//  Created by Youssef on 08/04/2023.
//

@testable import images_fetcher
import UIKit.UIImage
import UIKit.UIColor

class MockImageDetailsViewDelegate: ImageDetailsViewDelegate {
    var displayImageCalled = false
    var setBackgroundColorCalled = false
    var backgroundColor: UIColor?
    
    func displayImage(_ image: UIImage) {
        displayImageCalled = true
    }
    
    func setBackgroundColor(with color: UIColor) {
        setBackgroundColorCalled = true
        backgroundColor = color
    }
}
