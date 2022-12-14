//
//  AddCardVC.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//
import RealmSwift
import UIKit

final class AddCardVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var fonImageView: UIImageView!
    @IBOutlet private weak var numberTextField: UITextField!
    @IBOutlet private weak var dateTextField: UITextField!
    @IBOutlet private weak var cvcTextField: UITextField!
    @IBOutlet private weak var nameTextfield: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    
    // MARK: - Properties
    private var cardStorage = try! Realm()
    private var imageUrl: String?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addCardVC.delegate = self
        addCardVC.prefersGrabberVisible = true
        addCardVC.detents = [.medium()]
        config()
        loadBackgroundImage()
    }
    
    private func config() {
        // card image view
        fonImageView.layer.cornerRadius = 30
        // name text field
        nameTextfield.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        // save button
        saveButton.layer.cornerRadius = 15
        saveButton.layer.borderWidth = 3
        saveButton.layer.borderColor = #colorLiteral(red: 0.8207221627, green: 0.4692305923, blue: 0.257660836, alpha: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: UITextField.textDidChangeNotification, object: nil)
        saveButton.isEnabled = false
        // number text field
        numberTextField.delegate = self
        // date text field
        dateTextField.delegate = self
        // cvc text field
        cvcTextField.delegate = self
        // name text field
        nameTextfield.delegate = self
    }
    
    // MARK: - Methods
    private func loadBackgroundImage() {
        UnsplashNetworkManager.getImageFromStock { url in
            if let url = url {
                self.imageUrl = url
                if let data = try? Data(contentsOf: URL(string: self.imageUrl ?? "")!) {
                    self.fonImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func saveCard() {
        let card = CreditCard()
        guard let number = numberTextField.text,
              let date = dateTextField.text,
              let cvc = Int(cvcTextField.text!),
              let name = nameTextfield.text,
              let image = imageUrl else {
            return
        }
        card.number = number
        card.date = date
        card.cvc = cvc
        card.name = name
        card.fonImage = image
        cardStorage.beginWrite()
        cardStorage.add(card)
        try! cardStorage.commitWrite()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadCards"), object: nil)
        self.dismiss(animated: true)
    }
    
    // MARK: - Actions
    @objc private func textChanged(sender: Notification) {
        if numberTextField.hasText && numberTextField.text!.count == 19 &&
            dateTextField.hasText && dateTextField.text!.count == 5 &&
            cvcTextField.hasText && cvcTextField.text!.count == 3 &&
            nameTextfield.hasText && nameTextfield.text!.split(separator: " ").count == 2 {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction private func save(_ sender: UIButton) {
        saveCard()
    }
}

    // MARK: - Extensions
    // MARK: UISheetPresentationControllerDelegate
extension AddCardVC: UISheetPresentationControllerDelegate {
    private var addCardVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}

    // MARK: UITextFieldDelegate
extension AddCardVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == numberTextField {
            return formatCardNumber(textField: textField, shouldChangeCharactersInRange: range, replacementString: string)
        } else if textField == dateTextField {
            return formatDate(textField: textField, shouldChangeCharactersInRange: range, replacementString: string)
        } else if textField == cvcTextField {
            let maxLength = 3
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        } else if textField == nameTextfield {
            do {
                let maxLength = 18
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
                if regex.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count)) != nil {
                    return false
                }
                let currentString = (textField.text ?? "") as NSString
                let newString = currentString.replacingCharacters(in: range, with: string)
                return newString.count <= maxLength
            } catch {
            }
            return true
        }
        return true
    }
    
    private func formatDate(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == dateTextField {
            let replacementStringIsLegal = string.rangeOfCharacter(from: NSCharacterSet(charactersIn: "0123456789").inverted) == nil
            
            if !replacementStringIsLegal {
                return false
            }
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let components = newString.components(separatedBy: NSCharacterSet(charactersIn: "0123456789").inverted)
            let decimalString = components.joined(separator: "") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
            
            if length == 0 || (length > 4 && !hasLeadingOne) || length > 5 {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                
                return (newLength > 5) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            
            if hasLeadingOne {
                formattedString.append("1 ")
                index += 1
            }
            if length - index > 2 {
                let prefix = decimalString.substring(with: NSRange(location: index, length: 2))
                formattedString.appendFormat("%@/", prefix)
                index += 2
            }
            
            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
        } else {
            return true
        }
    }
    
    
    private func formatCardNumber(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == numberTextField {
            let replacementStringIsLegal = string.rangeOfCharacter(from: NSCharacterSet(charactersIn: "0123456789").inverted) == nil
            
            if !replacementStringIsLegal {
                return false
            }
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let components = newString.components(separatedBy: NSCharacterSet(charactersIn: "0123456789").inverted)
            let decimalString = components.joined(separator: "") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
            
            if length == 0 || (length > 16 && !hasLeadingOne) || length > 19 {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                
                return (newLength > 16) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            
            if hasLeadingOne {
                formattedString.append("1 ")
                index += 1
            }
            if length - index > 4 {
                let prefix = decimalString.substring(with: NSRange(location: index, length: 4))
                formattedString.appendFormat("%@ ", prefix)
                index += 4
            }
            
            if length - index > 4 {
                let prefix = decimalString.substring(with: NSRange(location: index, length: 4))
                formattedString.appendFormat("%@ ", prefix)
                index += 4
            }
            if length - index > 4 {
                let prefix = decimalString.substring(with: NSRange(location: index, length: 4))
                formattedString.appendFormat("%@ ", prefix)
                index += 4
            }
            
            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
        } else {
            return true
        }
    }
}
