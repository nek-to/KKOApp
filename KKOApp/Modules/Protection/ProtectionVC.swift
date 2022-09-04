//
//  ProtectionVC.swift
//  KKOApp
//
//  Created by VironIT on 4.09.22.
//
import Lottie
import UIKit

class ProtectionVC: UIViewController {
    @IBOutlet weak var lottieView: UIView!
    
    private let protection = AnimationView(name: "fingerprint")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLottie()
    }
    
    private func animateLottie() {
        protection.frame = lottieView.bounds
//        protection.center = lottieView.center
        protection.contentMode = .center
        protection.animationSpeed = 0.7
        protection.loopMode = .loop
        lottieView.addSubview(protection)
        protection.play()
    }
}
