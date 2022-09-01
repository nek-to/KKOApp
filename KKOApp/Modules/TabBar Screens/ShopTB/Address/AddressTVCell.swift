//
//  AddressTVCell.swift
//  KKOApp
//
//  Created by VironIT on 1.09.22.
//

import UIKit

class AddressTVCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 20
    }
}
