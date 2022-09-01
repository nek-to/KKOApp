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
        // email text fied
        emailTextField.regularStyle()
        // password text fied
        passwordTextField.passwordStyle()
        // log in button
        logInButton.layer.cornerRadius = logInButton.frame.height/2
        logInButton.alpha = 0.7
        // fone view
        blureFone()
        // text fields check
        textFieldsSetup()
    }
    
    private func checkIfFieldEmpty() {
        if emailTextField.hasText && passwordTextField.hasText {
            warningLabel.isHidden = true
            checkerIfFieldEmpty = false
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
    
    private func authantificationInFirebase() {
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
    
    private func textFieldsSetup() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        if let email = emailTextField.text, !email.isEmpty {
            emailTextField.emailValidation(email)
        }
        if let password = passwordTextField.text, !password.isEmpty {
            passwordTextField.passwordValidation(password)
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
            authantificationInFirebase()
        }
    }
    
    @IBAction private func moveToSignUpScreen(_ sender: UIButton) {
        toSignUp()
    }
    
}

