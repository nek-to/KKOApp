//
//  MapNewsVC.swift
//  KKOApp
//
//  Created by VironIT on 3.09.22.
//

import UIKit

final class MapNewsVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var mapImageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapNewsVC.delegate = self
        mapNewsVC.prefersGrabberVisible = true
        mapImageView.layer.cornerRadius = 20
    }
}

    // MARK: - Extensions: UISheetPresentationControllerDelegate
extension MapNewsVC: UISheetPresentationControllerDelegate {
    private var mapNewsVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}
