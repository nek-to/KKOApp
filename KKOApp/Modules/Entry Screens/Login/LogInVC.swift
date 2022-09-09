//
//  ViewController.swift
//  KKOApp
//
//  Created by VironIT on 19.08.22.
//
import FirebaseAuth
import UIKit

final class LogInVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var backgroundUmageView: UIImageView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordRestoreLabel: UILabel!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var loginFieldsBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var warningLabel: UILabel!
    
    // MARK: - Properties
    private var checkerIfFieldEmpty = true
    private var isSuccess = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    // MARK: - Setup
    private func config() {
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
    
    private func textFieldsSetup() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    // MARK: - Methods
    private func blureFone() {
        let blure = UIBlurEffect(style: .dark)
        let effect = UIVisualEffectView(effect: blure)
        effect.frame = backgroundUmageView.bounds
        backgroundUmageView.addSubview(effect)
    }
    
    private func checkIfFieldEmpty() {
        if emailTextField.hasText && passwordTextField.hasText {
            warningLabel.isHidden = true
            checkerIfFieldEmpty = false
        } else {
            warningLabel.isHidden = false
            hideWarningLabel()
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
        let tabBarScreen = UIStoryboard(name: Storyboards.mainTabBar.rawValue, bundle: nil).instantiateViewController(withIdentifier: Screens.mainTabBar.rawValue)
        self.present(tabBarScreen, animated: true)
    }
    
    private func toSignUp() {
        let signUpScreen = UIStoryboard(name: Storyboards.signup.rawValue, bundle: nil).instantiateViewController(withIdentifier: Screens.signup.rawValue)
        self.present(signUpScreen, animated: true)
    }
    
    private func authantificationInFirebase() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            guard error == nil else {
                return self.toSignUp()
            }
            self.toMainTabBar()
        }
    }
    
    private func restorePasswordAlert() {
        print("LOG: ")
        let alert = UIAlertController(title: "Restore password", message: "Please enter your email", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { text in
            text.placeholder = "Enter email"
        })
        alert.addAction(UIAlertAction(title: "Enter", style: .default, handler: { _ in
            let email = alert.textFields?.first?.text
            if let email = email {
                Auth.auth().fetchSignInMethods(forEmail: email) {(_, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        Auth.auth().sendPasswordReset(withEmail: email)
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    // MARK: - Actions
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
    
    @IBAction private func restorePassword(_ sender: UITapGestureRecognizer) {
        restorePasswordAlert()
    }
    
    @IBAction private func logIn(_ sender: UIButton) {
        checkIfFieldEmpty()
        hideWarningLabel()
        if checkerIfFieldEmpty == false {
            authantificationInFirebase()
        } else {
            toSignUp()
        }
    }
    
    @IBAction private func moveToSignUpScreen(_ sender: UIButton) {
        toSignUp()
    }
}
