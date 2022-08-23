//
//  ShopTableView.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

class ShopTableView: UITableView {
    @IBOutlet weak var height: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else {
            return
        }
        
        let offsetY = -contentOffset.y
        height?.constant = max(header.bounds.height, header.bounds.height + offsetY)
    }
}
