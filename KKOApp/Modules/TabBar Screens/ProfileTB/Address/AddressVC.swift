//
//  AddressVC.swift
//  KKOApp
//
//  Created by VironIT on 1.09.22.
//
import UIKit
import RealmSwift

final class AddressVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var addressTableView: UITableView!
    
    // MARK: - Properties
    private let address = CoffeeshopStorage.shared
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    // MARK: - Setup
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

    // MARK: - Extensions
    // MARK: UISheetPresentationControllerDelegate
extension AddressVC: UITableViewDelegate {
}

    // MARK: UISheetPresentationControllerDelegate
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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadAddress"), object: nil)
        self.dismiss(animated: true)
    }
    
    private func addressCellConfig(_ indexPath: IndexPath) -> UITableViewCell {
        let addressCell = addressTableView.dequeueReusableCell(withIdentifier: "addressCell") as! AddressTVCell
        addressCell.configureCell(address, indexPath)
        return addressCell
    }
}

    // MARK: UISheetPresentationControllerDelegate
extension AddressVC: UISheetPresentationControllerDelegate {
    private var addressVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}
