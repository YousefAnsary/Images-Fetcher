//
//  UITableView+Extensions.swift
//  Base
//
//  Created by Youssef on 06/01/2023.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(cellType: T.Type) {
        self.register(cellName: String(describing: cellType))
    }
    
    func register(cellName: String) {
        let nib = UINib(nibName: cellName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellName)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath)
        return cell as! T
    }
}
