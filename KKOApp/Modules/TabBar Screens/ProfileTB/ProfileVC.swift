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
        return preferenceCell
    }
}
