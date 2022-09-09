//
//  AnimationNewsVC.swift
//  KKOApp
//
//  Created by VironIT on 3.09.22.
//

import UIKit

final class AnimationNewsVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var animationImageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        animationNewsVC.delegate = self
        animationNewsVC.prefersGrabberVisible = true
        startConfig()
    }
    
    // MARK: - Setup
    private func startConfig() {
        // add gif image
        let gifImage = UIImage.gifImageWithName("animation")
        animationImageView.image = gifImage
        animationImageView.layer.cornerRadius = 20
    }
}

    // MARK: - Extensions: UISheetPresentationControllerDelegate
extension AnimationNewsVC: UISheetPresentationControllerDelegate {
    private var animationNewsVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}
