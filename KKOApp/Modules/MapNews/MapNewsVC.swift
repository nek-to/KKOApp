//
//  MapNewsVC.swift
//  KKOApp
//
//  Created by VironIT on 3.09.22.
//

import UIKit

class MapNewsVC: UIViewController {
    @IBOutlet weak var mapImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapNewsVC.delegate = self
        mapNewsVC.prefersGrabberVisible = true
        mapImageView.layer.cornerRadius = 20
    }
}

extension MapNewsVC: UISheetPresentationControllerDelegate {
    private var mapNewsVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}
