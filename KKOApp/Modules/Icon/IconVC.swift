//
//  ThemeVC.swift
//  KKOApp
//
//  Created by VironIT on 29.08.22.
//

import UIKit

final class IconVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var iconsTableView: UITableView!
    
    // MARK: - Properties
    private var iconsStorage = CustomIconsStorage.shared
    private var iconManager = AppIconManager()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        iconsTableView.delegate = self
        iconsTableView.dataSource = self
        iconVC.delegate = self
        iconVC.prefersGrabberVisible = true
        iconVC.detents = [.medium()]

    }
}

    // MARK: - Extensions
    // MARK: UITableViewDelegate
extension IconVC: UITableViewDelegate {
}

    // MARK: UITableViewDataSource
extension IconVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        iconsStorage.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iconCell = tableView.dequeueReusableCell(withIdentifier: "iconCell") as! IconTVCell
        iconCell.configureCell(iconsStorage.elements[indexPath.row])
        return iconCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UIApplication.shared.supportsAlternateIcons {
            switch indexPath.row {
            case 0:
                UIApplication.shared.setAlternateIconName(nil)
            case 1:
                iconManager.changeAppIcon(to: .blueberryIcon)
            case 2:
                iconManager.changeAppIcon(to: .goldenIcon)
            case 3:
                iconManager.changeAppIcon(to: .cozyIcon)
            case 4:
                iconManager.changeAppIcon(to: .cacaoIcon)
            default:
                UIApplication.shared.setAlternateIconName(nil)
            }
        }
    }
}

    // MARK: UISheetPresentationControllerDelegate
extension IconVC: UISheetPresentationControllerDelegate {
    private var iconVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}
