//
//  AnimationNewsVC.swift
//  KKOApp
//
//  Created by VironIT on 3.09.22.
//

import UIKit

class AnimationNewsVC: UIViewController {
    @IBOutlet weak var animationImageView: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        animationNewsVC.delegate = self
        animationNewsVC.prefersGrabberVisible = true
        startConfig()
    }
    
    private func startConfig() {
        // add gif image
        let gifImage = UIImage.gifImageWithName("animation")
        animationImageView.image = gifImage
        animationImageView.layer.cornerRadius = 20
    }
}

extension AnimationNewsVC: UISheetPresentationControllerDelegate {
    private var animationNewsVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}
