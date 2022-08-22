//
//  ViewController.swift
//  KKOApp
//
//  Created by VironIT on 19.08.22.
//
import Locksmith
import UIKit

class LogInVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var backgroundUmageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordRestoreLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var loginFieldsBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var warningLabel: UILabel!
    
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
        usernameTextField.layer.borderColor = UIColor.lightGray.cgColor
        usernameTextField.layer.cornerRadius = 7
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.cornerRadius = 7
        
        logInButton.layer.cornerRadius = logInButton.frame.height/2
        logInButton.alpha = 0.7
        blureFone()
    }
    
    private func checkIfFildEmpty() {
        if !usernameTextField.hasText || !passwordTextField.hasText {
            warningLabel.isHidden = false
            checkerIfFieldEmpty = true
        }
    }
    
    private func validateUser() {
        let validator = Locksmith.loadDataForUserAccount(userAccount: "KKOApp")
        guard validator!.isEmpty else { return }
        print(validator)
            isSuccess = true
        }
    
    private func hideWarningLabel() {
        if !warningLabel.isHidden {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.warningLabel.isHidden = true
            }
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
    
    @IBAction func logIn(_ sender: UIButton) {
        checkIfFildEmpty()
        hideWarningLabel()
        if !checkerIfFieldEmpty {
            validateUser()
            print(isSuccess)
        }
        print(isSuccess)
    }
    
    @IBAction func moveToSignUpScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        let signUpScreen = storyboard.instantiateViewController(withIdentifier: Screens.signup.rawValue)
        self.present(signUpScreen, animated: true)
    }
    
}

