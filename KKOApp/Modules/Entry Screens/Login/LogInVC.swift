//
//  ViewController.swift
//  KKOApp
//
//  Created by VironIT on 19.08.22.
//
import FirebaseAuth
import Simple_KeychainSwift
import UIKit

class LogInVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet private weak var backgroundUmageView: UIImageView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordRestoreLabel: UILabel!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var loginFieldsBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var warningLabel: UILabel!
    
    private var checkerIfFieldEmpty = true
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
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = emailTextField.frame.height/2
        emailTextField.leftViewMode = .always
        emailTextField.rightViewMode = .always
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 0))
        emailTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 0))
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height/2
        passwordTextField.leftViewMode = .always
        passwordTextField.rightViewMode = .always
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 0))
        passwordTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 0))
        
        logInButton.layer.cornerRadius = logInButton.frame.height/2
        logInButton.alpha = 0.7
        blureFone()
    }
    
    private func checkIfFieldEmpty() {
        if emailTextField.hasText && passwordTextField.hasText {
            warningLabel.isHidden = true
            checkerIfFieldEmpty = false
        }
    }
    
    private func validateUser() {
        if emailTextField.text == Keychain.value(forKey: "username") &&
            passwordTextField.text == Keychain.value(forKey: "password") {
            warningLabel.isHidden = false
            warningLabel.textColor = .green
        }
    }
    
    private func hideWarningLabel() {
        if !warningLabel.isHidden {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.warningLabel.isHidden = true
            }
        }
    }
    
    private func toMainTabBar() {
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        let tabBarScreen = storyboard.instantiateViewController(withIdentifier: Screens.mainTabBar.rawValue)
        self.present(tabBarScreen, animated: true)
    }
    
    private func toSignUp() {
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        let signUpScreen = storyboard.instantiateViewController(withIdentifier: Screens.signup.rawValue)
        self.present(signUpScreen, animated: true)
    }
    
    private func aythantificationInFirebase() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let strongSelf = self else { return }
            guard error == nil else {
                return strongSelf.toSignUp()
            }
            strongSelf.toMainTabBar()
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
            self.loginFieldsBottomConstraint.constant = 200
        } else {
            self.loginFieldsBottomConstraint.constant = ((endFrame?.size.height)! + 20)
        }
    }
    
    @IBAction private func logIn(_ sender: UIButton) {
        checkIfFieldEmpty()
        hideWarningLabel()
        print(checkerIfFieldEmpty)
        if checkerIfFieldEmpty == false {
            aythantificationInFirebase()
            print("Auth")
        }
    }
    
    @IBAction private func moveToSignUpScreen(_ sender: UIButton) {
        toSignUp()
    }
    
}

