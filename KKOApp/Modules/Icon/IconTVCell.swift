//
//  IconTVCell.swift
//  KKOApp
//
//  Created by VironIT on 29.08.22.
//

import UIKit

class IconTVCell: UITableViewCell {
    @IBOutlet weak var iconTitleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    private var icon: CustomIcon?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    private func config() {
        iconImageView.layer.cornerRadius = 10
    }
    
    func configureCell(_ icon: CustomIcon) {
        iconTitleLabel.text = icon.title
        iconImageView.image = UIImage(named: icon.image)
    }
}
