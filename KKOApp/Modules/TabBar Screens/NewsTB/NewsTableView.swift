//
//  NewsTableView.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

class NewsTableView: UITableView {
    var height: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else {
            return
        }
        if let imageView = header.subviews.first as? UIImageView {
            height = imageView.constraints.filter { $0.identifier == "height" }.first
            bottom = header.constraints.filter { $0.identifier == "bottom" }.first
        }
        
        let offsetY = -contentOffset.y
        bottom?.constant = offsetY >= 0 ? 0 : offsetY / 2
        height?.constant = max(header.bounds.height, header.bounds.height + offsetY)
        
        header.clipsToBounds = offsetY <= 0
    }
}
