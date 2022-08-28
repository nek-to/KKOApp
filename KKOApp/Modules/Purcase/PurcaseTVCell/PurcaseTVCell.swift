//
//  PurcaseTVCell.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//
import Lottie
import RealmSwift
import UIKit

class PurcaseTVCell: UITableViewCell {
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var titleBackView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lottieBackView: UIView!
    @IBOutlet weak var lottieRoundView: UIView!
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var greenTickImageView: UIImageView!
    
    private var item: Purcase?
    private var brewCoffee = AnimationView(name: "brewing-coffee")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    private func config() {
        // image
        coffeeImageView.layer.cornerRadius = 30
        // title back
        titleBackView.layer.cornerRadius = 15
        // lottie back
        lottieBackView.layer.cornerRadius = 15
        // lottie round
        lottieRoundView.layer.cornerRadius = lottieRoundView.frame.height/2
        // lottie
        lottieView.backgroundColor = .clear
    }
    
    func coffeeBrewed() {
        brewCoffee.isHidden = true
        greenTickImageView.isHidden = false
    }
    
    func configureCell(_ coffee: Purcase) {
        item = coffee
        titleLabel.text = item?.title
        coffeeImageView.image = UIImage().resizeImage(image: .init(named: item?.image ?? "")!,
                                                      targetSize: .init(width: 300, height: 300))
    }
    
    func animateBrewingCoffee() {
        brewCoffee.frame = lottieBackView.frame
        brewCoffee.center = lottieView.center
        brewCoffee.contentMode = .scaleAspectFit
        brewCoffee.loopMode = .playOnce
        lottieRoundView.addSubview(brewCoffee)
        brewCoffee.play { complition in
            self.lottieRoundView.layer.borderWidth = 6
            self.lottieRoundView.layer.borderColor = .init(red: 0, green: 1, blue: 0, alpha: 0.4)
            self.coffeeBrewed()
        }
    }
}