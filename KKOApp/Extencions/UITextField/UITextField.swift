//
//  UITextField.swift
//  KKOApp
//
//  Created by VironIT on 1.09.22.
//

import Foundation
import UIKit

extension UITextField {
    func emailValidation(_ email: String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) != true {
            self.layer.borderColor = UIColor.red.cgColor
        } else {
            self.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    func passwordValidation(_ password: String) {
        if password.count < 6 {
            self.layer.borderColor = UIColor.red.cgColor
        } else {
            self.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    func phoneValidation(_ phone: String) {
        let phoneRegEx = "^[+375]{4}+[0-9]{9}$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        if phonePred.evaluate(with: phone) != true {
            self.layer.borderColor = UIColor.red.cgColor
        } else {
            self.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    func usernameValidation(_ username: String) {
        if username.count < 2 {
            self.layer.borderColor = UIColor.red.cgColor
        } else {
            self.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    func regularStyle() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.frame.height/2
        self.leftViewMode = .always
        self.rightViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 0))
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 0))
    }
    
    func passwordStyle() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
        self.isSecureTextEntry = true
        self.layer.cornerRadius = self.frame.height/2
        self.leftViewMode = .always
        self.rightViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 0))
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 0))
    }
}
