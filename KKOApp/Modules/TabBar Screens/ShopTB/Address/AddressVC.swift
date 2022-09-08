//
//  AddressVC.swift
//  KKOApp
//
//  Created by VironIT on 1.09.22.
//
import UIKit
import RealmSwift

class AddressVC: UIViewController {
    @IBOutlet weak var addressTableView: UITableView!
    
    private let address = CoffeeshopStorage.shared
    var closure: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        // view setup
        addressVC.delegate = self
        addressVC.prefersGrabberVisible = true
        addressVC.detents = [.medium()]
        // address tableview
        addressTableView.delegate = self
        addressTableView.dataSource = self
    }
}

extension AddressVC: UITableViewDelegate {
}

extension AddressVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        address.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        addressCellConfig(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserSettings.coffeeshopAddress = address.elements[indexPath.row].address
        if let address = UserSettings.coffeeshopAddress, !address.isEmpty {
            closure?(address)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadAddress"), object: nil)
        self.dismiss(animated: true)
    }
    
    private func addressCellConfig(_ indexPath: IndexPath) -> UITableViewCell {
        let addressCell = addressTableView.dequeueReusableCell(withIdentifier: "addressCell") as! AddressTVCell
        addressCell.nameLabel.text = address.elements[indexPath.row].name
        addressCell.addressLabel.text = address.elements[indexPath.row].address
        addressCell.iconImageView.image = UIImage(named: address.elements[indexPath.row].icon)
        addressCell.selectionStyle = .none
        return addressCell
    }
}

extension AddressVC: UISheetPresentationControllerDelegate {
    private var addressVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}
