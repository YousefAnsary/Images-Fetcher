//
//  AdTableCell.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import UIKit

class AdTableCell: UITableViewCell, AdTableCellProtocol {

    @IBOutlet private weak var label: UILabel!
    
    func configure(title: String) {
        self.label.text = title
    }
}
