//
//  SignUpViewController.swift
//  KKOApp
//
//  Created by VironIT on 19.08.22.
//
import Simple_KeychainSwift
import UIKit

class SignUpVC: UIViewController {
    @IBOutlet private weak var backgroundUmageView: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var repeatePasswordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var warningLabel: UILabel!
    @IBOutlet private weak var singupFormButtonConstraint: NSLayoutConstraint!
    
    private var passwordsIsCorrect = false
    private var fieldsAreFill = false
    
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
        nameTextField.layer.cornerRadius = 7
        phoneTextField.layer.borderColor = UIColor.lightGray.cgColor
        phoneTextField.layer.cornerRadius = 7
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.cornerRadius = 7
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.cornerRadius = 7
        repeatePasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        repeatePasswordTextField.layer.cornerRadius = 7
        
        signUpButton.layer.cornerRadius = signUpButton.frame.height/2
        signUpButton.alpha = 0.7
        blureFone()
    }
    
    private func checkIfDoublePasswordCorrect() {
        guard passwordTextField.hasText && repeatePasswordTextField.hasText else { return }
        if passwordTextField.text == repeatePasswordTextField.text {
            passwordsIsCorrect = true
        }
    }
    
    private func checkIfAllFieldsAreFill() {
        if !nameTextField.hasText ||
            !phoneTextField.hasText ||
            !emailTextField.hasText ||
            !passwordTextField.hasText ||
            !repeatePasswordTextField.hasText {
            warningLabel.isHidden = false
        } else {
            fieldsAreFill = true
        }
    }
    
    private func hideWarningLabel() {
        if warningLabel.isHidden == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.warningLabel.isHidden = true
            }
        }
    }
    
    private func saveUserInDatabase() {
        print("password correct = \(passwordsIsCorrect)")
        print("warning label is hide = \(warningLabel.isHidden)")
        if warningLabel.isHidden && passwordsIsCorrect {
            Keychain.set(nameTextField.text, forKey: "username")
            Keychain.set(phoneTextField.text, forKey: "phone")
            Keychain.set(emailTextField.text, forKey: "email")
            Keychain.set(passwordTextField.text, forKey: "password")
        } else {
            warningLabel.isHidden = false
            print("registration error")
        }
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
    
    @IBAction private func signUp(_ sender: Any) {
        checkIfAllFieldsAreFill()
        checkIfDoublePasswordCorrect()
        hideWarningLabel()
        print(fieldsAreFill)
        print(passwordsIsCorrect)
        if fieldsAreFill && passwordsIsCorrect {
            saveUserInDatabase()
        }
    }
}