//
//  SignUpViewController.swift
//  KKOApp
//
//  Created by VironIT on 19.08.22.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var backgroundUmageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatePasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var singupFormButtonConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchSetup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    private func blureFone() {
        let blure = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let effect = UIVisualEffectView(effect: blure)
        effect.frame = backgroundUmageView.bounds
        backgroundUmageView.addSubview(effect)
    }
    
    private func launchSetup() {
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = nameTextField.frame.height/2
        phoneTextField.layer.borderColor = UIColor.lightGray.cgColor
        phoneTextField.layer.borderWidth = 1
        phoneTextField.layer.cornerRadius = phoneTextField.frame.height/2
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = emailTextField.frame.height/2
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height/2
        repeatePasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        repeatePasswordTextField.layer.borderWidth = 1
        repeatePasswordTextField.layer.cornerRadius = repeatePasswordTextField.frame.height/2
        
        signUpButton.layer.cornerRadius = signUpButton.frame.height/2
        signUpButton.alpha = 0.7
        blureFone()
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardNotification(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }

        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0.0

        if endFrameY >= UIScreen.main.bounds.size.height {
            self.singupFormButtonConstraint.constant = 150
        } else {
            self.singupFormButtonConstraint.constant = ((endFrame?.size.height)!)
        }
    }
}
