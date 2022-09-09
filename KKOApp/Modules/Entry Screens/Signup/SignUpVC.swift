//
//  SignUpViewController.swift
//  KKOApp
//
//  Created by VironIT on 19.08.22.
//
import FirebaseAuth
import RealmSwift
import UIKit

final class SignUpVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var backgroundUmageView: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var repeatePasswordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var warningLabel: UILabel!
    @IBOutlet private weak var singupFormBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var signupLabelBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    private var storage = try! Realm()
    private var passwordsIsCorrect = false
    private var fieldsAreFill = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        launchSetup()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }

    // MARK: - Setup
    private func launchSetup() {
        // name text field
        nameTextField.regularStyle()
        // phone text field
        phoneTextField.regularStyle()
        phoneTextField.delegate = self
        // email text field
        emailTextField.regularStyle()
        // passwprd text field
        passwordTextField.passwordStyle()
        // repeat password text field
        repeatePasswordTextField.passwordStyle()
        // wrning label
        warningLabel.isHidden = true
        // sign up button
        signUpButton.layer.cornerRadius = signUpButton.frame.height/2
        signUpButton.alpha = 0.7
        // fone view
        blureFone()
        // text fields setup
        textfieldSetup()
    }
    
    private func blureFone() {
        let blure = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let effect = UIVisualEffectView(effect: blure)
        effect.frame = backgroundUmageView.bounds
        backgroundUmageView.addSubview(effect)
    }
    
    private func textfieldSetup() {
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        phoneTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        repeatePasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    // MARK: - Methods
    private func checkIfDoublePasswordCorrect() {
        guard passwordTextField.hasText && repeatePasswordTextField.hasText else { return }
        if passwordTextField.text!.contains(repeatePasswordTextField.text!) {
            passwordsIsCorrect = true
        } else {
            warningLabel.isHidden = false
            hideWarningLabel()
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
    
    private func showSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: "Welcome to KKO coffee shop", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: .default) { [weak self] _ in
            self?.toMainTabBar()
            alert.dismiss(animated: true)
        })
        self.present(alert, animated: true)
    }
    
    
    private func signUpFaildAlert() {
        let alert = UIAlertController(title: "Sign up is faild", message: "Something goes wrong. Please check your data and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default) { _ in
            alert.dismiss(animated: true)
        })
        self.present(alert, animated: true)
    }
    
    private func saveUserInDatabase() {
        if warningLabel.isHidden && passwordsIsCorrect {
            // realm
            let user = Profile()
            try? storage.write {
                user.user = nameTextField.text
                user.phone = phoneTextField.text
                user.email = emailTextField.text
                storage.add(user)
            }
        } else {
            warningLabel.isHidden = false
        }
    }

    private func saveUserInFirebase() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            guard error == nil else {
                return self.signUpFaildAlert()
            }
            Auth.auth().currentUser?.sendEmailVerification()
            self.showSuccessAlert()
        }
    }
    
    // MARK: - Actions
    @objc private func textFieldDidChange() {
        if let name = nameTextField.text, !name.isEmpty {
            nameTextField.usernameValidation(name)
        }
        
        if let phone = phoneTextField.text, !phone.isEmpty {
            phoneTextField.phoneValidation(phone)
        }
        
        if let email = emailTextField.text, !email.isEmpty {
            emailTextField.emailValidation(email)
        }
        
        if let password = passwordTextField.text, !password.isEmpty {
            passwordTextField.passwordValidation(password)
        }
        
        if let repeatPassword = repeatePasswordTextField.text, !repeatPassword.isEmpty {
            repeatePasswordTextField.passwordValidation(repeatPassword)
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
            self.singupFormBottomConstraint.constant = 150
            self.signupLabelBottomConstraint.constant = 70
        } else {
            self.singupFormBottomConstraint.constant = ((endFrame?.size.height)!)
            self.signupLabelBottomConstraint.constant = ((endFrame?.size.height)!)
        }
    }
    
    @IBAction private func signUp(_ sender: Any) {
        checkIfAllFieldsAreFill()
        checkIfDoublePasswordCorrect()
        if fieldsAreFill && passwordsIsCorrect {
            saveUserInDatabase()
            saveUserInFirebase()
        }
    }
}

// MARK: - Extensions: UITextFieldDelegate
extension SignUpVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if text.count < 4 {
            return text ~= "+375"
        }
        return true
    }
}
