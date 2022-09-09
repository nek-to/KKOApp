//
//  NewsTableView.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

final class NewsTableView: UITableView {
    // MARK: - Properties
    private var height: NSLayoutConstraint?
    private var bottom: NSLayoutConstraint?
    
    // MARK: - Layout
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
