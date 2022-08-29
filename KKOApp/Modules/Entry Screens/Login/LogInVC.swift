//
//  ViewController.swift
//  KKOApp
//
//  Created by VironIT on 19.08.22.
//
import Simple_KeychainSwift
import UIKit

class LogInVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet private weak var backgroundUmageView: UIImageView!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordRestoreLabel: UILabel!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var loginFieldsBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var warningLabel: UILabel!
    
    private var checkerIfFieldEmpty = false
    private var isSuccess = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchSetup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }

    private func blureFone() {
        let blure = UIBlurEffect(style: .dark)
        let effect = UIVisualEffectView(effect: blure)
        effect.frame = backgroundUmageView.bounds
        backgroundUmageView.addSubview(effect)
    }
    
    private func launchSetup() {
        usernameTextField.layer.borderColor = UIColor.lightGray.cgColor
        usernameTextField.layer.cornerRadius = 7
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.cornerRadius = 7
        
        logInButton.layer.cornerRadius = logInButton.frame.height/2
        logInButton.alpha = 0.7
        blureFone()
    }
    
    private func checkIfFieldEmpty() {
        if !usernameTextField.hasText || !passwordTextField.hasText {
            warningLabel.isHidden = false
            checkerIfFieldEmpty = true
        }
    }
    
    private func validateUser() {
        if usernameTextField.text == Keychain.value(forKey: "username") &&
            passwordTextField.text == Keychain.value(forKey: "password") {
            warningLabel.isHidden = false
            warningLabel.textColor = .green
        }
    }
    
    private func hideWarningLabel() {
        if !warningLabel.isHidden {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.warningLabel.isHidden = true
            }
        }
    }
    
    private func toMainTabBar() {
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        let tabBarScreen = storyboard.instantiateViewController(withIdentifier: Screens.mainTabBar.rawValue)
        self.present(tabBarScreen, animated: true)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardNotification(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0.0
        
        if endFrameY >= UIScreen.main.bounds.size.height {
            self.loginFieldsBottomConstraint.constant = 200
        } else {
            self.loginFieldsBottomConstraint.constant = ((endFrame?.size.height)! + 20)
        }
    }
    
    @IBAction private func logIn(_ sender: UIButton) {
        checkIfFieldEmpty()
        hideWarningLabel()
        if !checkerIfFieldEmpty {
            validateUser()
//            isSuccess = true
            toMainTabBar()
        }
    }
    
    @IBAction private func moveToSignUpScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        let signUpScreen = storyboard.instantiateViewController(withIdentifier: Screens.signup.rawValue)
        self.present(signUpScreen, animated: true)
    }
    
}

