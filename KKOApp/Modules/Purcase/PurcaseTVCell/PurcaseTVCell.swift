//
//  PurcaseTVCell.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//
import Lottie
import RealmSwift
import UIKit

final class PurcaseTVCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var coffeeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var lottieBackView: UIView!
    @IBOutlet private weak var lottieRoundView: UIView!
    @IBOutlet private weak var lottieView: UIView!
    @IBOutlet private weak var greenTickImageView: UIImageView!
    
    // MARK: - Properties
    private var brewCoffee = AnimationView(name: "brewing-coffee")
    private var buyTime = Date()
    private let currentDate = Date()

    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
        
    }
    
    // MARK: - Setup
    private func config() {
        // image
        coffeeImageView.layer.cornerRadius = 30
        // lottie back
        lottieBackView.layer.cornerRadius = 15
        // lottie round
        lottieRoundView.layer.cornerRadius = lottieRoundView.frame.height/2
        // lottie
        lottieView.backgroundColor = .clear
    }
    
    func configureCell(_ coffee: Purcase) {
        titleLabel.text = coffee.title
        coffeeImageView.image = UIImage().resizeImage(image: .init(named: coffee.image)!,
                                                      targetSize: .init(width: 300, height: 300))
    }
    
    // MARK: - Methods
    func coffeeBrewed() {
        brewCoffee.isHidden = true
        greenTickImageView.isHidden = false
    }
    
    func animateBrewingCoffee(_ coffee: Purcase) {
        brewCoffee.frame = CGRect(x: 0, y: 0, width: 110, height: 110)
        brewCoffee.center = lottieView.center
        brewCoffee.contentMode = .scaleAspectFit
        brewCoffee.loopMode = .playOnce
        lottieRoundView.addSubview(brewCoffee)
        
        let diffComponents = currentDate.timeIntervalSince(coffee.buyTiming)
        let frame: Double = 175 / coffee.time
        var currentFrame = frame * diffComponents
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] timer in
            currentFrame += frame / 50
            self?.brewCoffee.currentFrame = currentFrame
            if currentFrame >= 175 {
                timer.invalidate()
                self?.lottieRoundView.layer.borderWidth = 6
                self?.lottieRoundView.layer.borderColor = .init(red: 0, green: 1, blue: 0, alpha: 0.4)
                self?.coffeeBrewed()
            }
        }
        brewCoffee.play(fromFrame: 0, toFrame: 175, loopMode: .none)
    }
}
