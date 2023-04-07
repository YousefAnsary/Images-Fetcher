//
//  ImageTableCell.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import UIKit

class ImageTableCell: UITableViewCell, ImageTableCellProtocol {

    @IBOutlet private weak var loadedImageView: UIImageView!
    @IBOutlet private weak var authorNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadedImageView.layer.cornerRadius = 12
    }

    func configure(imageURL: String, authorName: String) {
        self.loadedImageView.loadImage(fromURL: imageURL)
        self.authorNameLabel.text = authorName
    }

    func getImage() -> UIImage? {
        return self.loadedImageView.image
    }
}
