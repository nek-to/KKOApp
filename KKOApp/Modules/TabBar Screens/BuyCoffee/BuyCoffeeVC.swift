//
//  BuyCoffeeVC.swift
//  KKOApp
//
//  Created by Kolya Gribok on 24.08.22.
//

import UIKit

protocol CoffeeProtocol {
    var name: String { get set }
    var descript: String { get set }
    var price: UInt { get set }
    var imageName: String { get set }
}

class BuyCoffeeVC: UIViewController, CoffeeProtocol {
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var foneImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeSButton: UIButton!
    @IBOutlet weak var sizeMButton: UIButton!
    @IBOutlet weak var sizeLButton: UIButton!
    @IBOutlet weak var cardBackgroundView: UIView!
    
    var name: String = ""
    var descript: String = ""
    var price: UInt = 0
    var imageName: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blureFone()
        blureView()
        configure(title: name, descript: descript, price: price, image: imageName)
    }
    
    private func configure(title: String, descript: String, price: UInt, image: String) {
        titleLabel.text = title
        descriptionLabel.text = descript
        priceLabel.text = "\(price).0"
        coffeeImageView.image = UIImage().resizeImage(image: .init(named: image)!, targetSize: .init(width: 400, height: 400))
        foneImageView.image = UIImage().resizeImage(image: .init(named: image)!, targetSize: .init(width: 400, height: 400))
        coffeeImageView.layer.cornerRadius = 40
    }
    
    private func blureFone() {
        let blure = UIBlurEffect(style: .prominent)
        let effect = UIVisualEffectView(effect: blure)
        effect.frame = foneImageView.bounds
        foneImageView.addSubview(effect)
    }
    
    private func blureView() {
        let blure = UIBlurEffect(style: .dark)
        let effect = UIVisualEffectView(effect: blure)
        effect.frame = cardBackgroundView.bounds
        cardBackgroundView.addSubview(effect)
        cardBackgroundView.layer.cornerRadius = 40
    }
}
