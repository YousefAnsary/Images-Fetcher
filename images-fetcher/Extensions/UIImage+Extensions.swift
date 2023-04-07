//
//  UIImage+Extensions.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import UIKit
import CoreImage

extension UIImage {

    func extractDominantColor() -> UIColor {
        guard let inputImage = CIImage(image: self) else { return UIColor.clear }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector])!
        var pixel = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: nil)
        context.render(filter.outputImage!, toBitmap: &pixel, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        return UIColor(red: CGFloat(pixel[0]) / 255.0, green: CGFloat(pixel[1]) / 255.0, blue: CGFloat(pixel[2]) / 255.0, alpha: 1)
    }
}
