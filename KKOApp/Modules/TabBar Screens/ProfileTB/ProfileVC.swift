//
//  ProfileVC.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var preferenceTableView: UITableView!
    @IBOutlet weak var profilePicNameLabel: UILabel!
    
    private var preferences = PreferenceStorage.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferenceTableView.delegate = self
        preferenceTableView.dataSource = self
        config()
    }
    
    private func config() {
        // profile picture
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
        profilePictureImageView.backgroundColor = UIColor.orange
        profilePictureImageView.layer.borderColor = UIColor.white.cgColor
        profilePictureImageView.layer.borderWidth = 3
//        profilePicNameLabel.text
        // background picture
        topImageView.layer.cornerRadius = 30
    }
}

extension ProfileVC: UITableViewDelegate {
}

extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        preferences.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let preferenceCell = tableView.dequeueReusableCell(withIdentifier: "preferenceCell") as! PreferenceTVCell
        preferenceCell.preferenceLabel.text = preferences.elements[indexPath.row].title
        let icon = preferences.elements[indexPath.row].icon
        preferenceCell.iconImageView.image = UIImage(named: icon)
        preferenceCell.selectionStyle = .none
        return preferenceCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = preferences.elements[indexPath.row].title
        selectPreferenceOption(option)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    private func selectPreferenceOption(_ option: String) {
        switch option {
        case Preferences.location.rawValue:
            let storyboard = UIStoryboard(name: "Map", bundle: nil)
            let mapScreen = storyboard.instantiateViewController(withIdentifier: Screens.map.rawValue)
            self.present(mapScreen, animated: true)
        case Preferences.payment.rawValue:
            let storyboard = UIStoryboard(name: "Map", bundle: nil)
            let mapScreen = storyboard.instantiateViewController(withIdentifier: Screens.map.rawValue)
            self.present(mapScreen, animated: true)
        case Preferences.purcase.rawValue:
            let storyboard = UIStoryboard(name: "Map", bundle: nil)
            let mapScreen = storyboard.instantiateViewController(withIdentifier: Screens.map.rawValue)
            self.present(mapScreen, animated: true)
        case Preferences.general.rawValue:
            let storyboard = UIStoryboard(name: "Map", bundle: nil)
            let mapScreen = storyboard.instantiateViewController(withIdentifier: Screens.map.rawValue)
            self.present(mapScreen, animated: true)
        case Preferences.logout.rawValue:
            let storyboard = UIStoryboard(name: "Map", bundle: nil)
            let mapScreen = storyboard.instantiateViewController(withIdentifier: Screens.map.rawValue)
            self.present(mapScreen, animated: true)
        default: break
        }
    }
}
