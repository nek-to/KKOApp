//
//  ShopTableView.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

final class ShopTableView: UITableView {
    // MARK: - Outlets
    @IBOutlet private weak var height: NSLayoutConstraint!
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let header = tableHeaderView else {
            return
        }
        let offsetY = -contentOffset.y
        height?.constant = max(header.bounds.height, header.bounds.height + offsetY)
    }
}
