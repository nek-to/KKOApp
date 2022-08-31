//
//  CardTVCell.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//

import UIKit

class CardTVCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var fonImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fonImageView.layer.cornerRadius = 30
        mainView.layer.cornerRadius = 30
    }
    
    func configureCell(_ card: CreditCard) {
        fonImageView.image = UIImage(data: try! Data(contentsOf: URL(string: card.fonImage)!))
        numberLabel.text = card.number
        dateLabel.text = card.date
        nameLabel.text = card.name
    }
}
