//
//  CardTVCell.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//

import UIKit

final class CardTVCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var fonImageView: UIImageView!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        fonImageView.layer.cornerRadius = 30
    }
    
    // MARK: - Setup
    func configureCell(_ card: CreditCard) {
        fonImageView.image = UIImage(data: try! Data(contentsOf: URL(string: card.fonImage)!))
        numberLabel.text = card.number
        dateLabel.text = card.date
        nameLabel.text = card.name
    }
}
