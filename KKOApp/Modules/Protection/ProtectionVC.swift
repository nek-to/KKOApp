//
//  ProtectionVC.swift
//  KKOApp
//
//  Created by VironIT on 4.09.22.
//
import Lottie
import UIKit

final class ProtectionVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var lottieView: UIView!
    
    // MARK: - Properties
    private let protection = AnimationView(name: "fingerprint")
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLottie()
    }

    // MARK: - Methods
    private func animateLottie() {
        protection.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        protection.contentMode = .center
        protection.animationSpeed = 0.6
        protection.loopMode = .loop
        lottieView.addSubview(protection)
        protection.play()
    }
}
