//
//  CoffeeTVCell.swift
//  KKOApp
//
//  Created by VironIT on 23.08.22.
//

import UIKit

class CoffeeTVCell: UITableViewCell {
    @IBOutlet weak var coffeeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descritionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    private var item: CoffeeItem?
    internal var likeIndicator = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coffeeImage.layer.cornerRadius = 20
        self.backgroundColor = .black
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if likeIndicator {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func configure(_ coffee: CoffeeItem) {
        titleLabel.text = coffee.name
        descritionLabel.text = coffee.description
        priceLabel.text = String("\(coffee.price)$")
        coffeeImage.image = UIImage().resizeImage(image: .init(named: coffee.imageName)!,
                                                  targetSize: .init(width: 300, height: 300))
        likeButton.isSelected = coffee.like
    }
    
    @IBAction func likeCoffee(_ sender: UIButton) {
        item?.like = false
        if !likeButton.isSelected {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeIndicator = true
            likeButton.isSelected = true
        }
        else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeIndicator = false
            likeButton.isSelected = false
        }
    }
}
