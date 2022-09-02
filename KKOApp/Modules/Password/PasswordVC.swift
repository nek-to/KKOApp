//
//  PasswordViewController.swift
//  KKOCoffee
//
//  Created by VironIT on 10.08.22.
//

import UIKit
import LocalAuthentication

class PasswordVC: UIViewController {
    
    @IBOutlet private weak var passwordImageView: UIImageView!

    override func viewDidLoad() {
     super.viewDidLoad()
    }
    
    
    @IBAction func aouthorization(_ sender: UITapGestureRecognizer) {
        authorization()
    }
    
    private func authorization() {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authorized") { success, error in
                if success {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
}
