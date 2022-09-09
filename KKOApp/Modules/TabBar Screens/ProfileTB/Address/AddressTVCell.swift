//
//  AddressTVCell.swift
//  KKOApp
//
//  Created by VironIT on 1.09.22.
//

import UIKit

final class AddressTVCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 20
    }
    
    // MARK: - Setup
    func configureCell(_ address: CoffeeshopStorage, _ index: IndexPath) {
        nameLabel.text = address.elements[index.row].name
        addressLabel.text = address.elements[index.row].address
        iconImageView.image = UIImage(named: address.elements[index.row].icon)
    }
}
