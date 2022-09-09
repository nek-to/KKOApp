//
//  PasswordViewController.swift
//  KKOCoffee
//
//  Created by VironIT on 10.08.22.
//

import UIKit
import LocalAuthentication

final class PasswordVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var passwordImageView: UIImageView!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
     super.viewDidLoad()
    }
    
    // MARK: - Methods
    private func authorization() {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authorized") { success, _ in
                if success {
                    DispatchQueue.main.async { [weak self] in
                        self?.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction private func aouthorization(_ sender: UITapGestureRecognizer) {
        authorization()
    }
}
