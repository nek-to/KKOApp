//
//  CoffeeTVCell.swift
//  KKOApp
//
//  Created by VironIT on 23.08.22.
//
import RealmSwift
import UIKit


class CoffeeTVCell: UITableViewCell {
    @IBOutlet weak var coffeeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descritionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    private var storage = try! Realm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coffeeImage.layer.cornerRadius = 20
        self.backgroundColor = .black
    }

    
    func configure(_ coffee: Coffee) {
        titleLabel.text = coffee.name
        descritionLabel.text = coffee.descript
        priceLabel.text = String("\(coffee.price)$")
        coffeeImage.image = UIImage().resizeImage(image: .init(named: coffee.imageName)!,
                                                  targetSize: .init(width: 300, height: 300))
        if coffee.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func likeCoffee(_ sender: UIButton) {
        guard let title = titleLabel.text else { return }
        guard let coffee = storage.object(ofType: Coffee.self, forPrimaryKey: title) else { return }
        
        if !coffee.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            try? storage.write {
                coffee.like.toggle()
            }
        }
        else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            try? storage.write {
                coffee.like.toggle()
            }
        }
    }
}

