//
//  LanguageVC.swift
//  KKOApp
//
//  Created by VironIT on 29.08.22.
//

import UIKit

class LanguageVC: UIViewController {
    @IBOutlet weak var languagePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageVC.delegate = self
        languagePickerView.delegate = self
        languagePickerView.dataSource = self
    }
    
    var languages: [Language] = [.korean, .english(.us), .english(.uk), .english(.australian), .english(.canadian), .english(.indian),
                                 .chinese(.simplified), .chinese(.traditional), .chinese(.hongKong),
                                 .japanese, .russian]
}

extension LanguageVC: UIPickerViewDelegate {
}

extension LanguageVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        languages[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        <#code#>
    }
}

extension LanguageVC: UISheetPresentationControllerDelegate {
    private var languageVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}
