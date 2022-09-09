//
//  IconTVCell.swift
//  KKOApp
//
//  Created by VironIT on 29.08.22.
//

import UIKit

final class IconTVCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var iconTitleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    // MARK: - Properties
    private var icon: CustomIcon?
    
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    // MARK: - Setup
    private func config() {
        iconImageView.layer.cornerRadius = 10
    }
    
    func configureCell(_ icon: CustomIcon) {
        iconTitleLabel.text = icon.title
        iconImageView.image = UIImage(named: icon.image)
    }
}
