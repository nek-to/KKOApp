//
//  ProfileVC.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//
import RealmSwift
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
    private var imageUrl = ""
    private var topImageStorage = try! Realm()
    
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
        // background picture
        topImageView.layer.cornerRadius = 30
        // top image
        setupTopImage()
    }
    
    private func setupTopImage() {
        if topImageStorage.isEmpty {
            topImageView.image = UIImage(named: "profile-back")
        } else {
            let images = topImageStorage.objects(TopImage.self)
            let image = images.first?.image ?? ""
            if let data = try? Data(contentsOf: URL(string: image)!) {
                topImageView.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction private func reloadFonImage() {
        UnsplashNetworkManager.getImageFromStock { url in
            if let url = url {
                self.imageUrl = url
                self.saveTopImage(url: url)
                if let data = try? Data(contentsOf: URL(string: url )!) {
                    self.topImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func saveTopImage(url: String) {
        let topImage = TopImage()
        topImage.image = self.imageUrl
        topImageStorage.beginWrite()
        topImageStorage.delete(topImageStorage.objects(TopImage.self))
        topImageStorage.add(topImage)
        try? topImageStorage.commitWrite()
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
            let storyboard = UIStoryboard(name: "Payment", bundle: nil)
            let paymentScreen = storyboard.instantiateViewController(withIdentifier: Screens.payment.rawValue)
            self.present(paymentScreen, animated: true)
        case Preferences.purcase.rawValue:
            let storyboard = UIStoryboard(name: "Purcase", bundle: nil)
            let purcaseScreen = storyboard.instantiateViewController(withIdentifier: Screens.purcase.rawValue)
            self.present(purcaseScreen, animated: true)
        case Preferences.icon.rawValue:
            let storyboard = UIStoryboard(name: "Icon", bundle: nil)
            let iconScreen = storyboard.instantiateViewController(withIdentifier: Screens.icon.rawValue)
            self.present(iconScreen, animated: true)
        case Preferences.language.rawValue:
            let storyboard = UIStoryboard(name: "Language", bundle: nil)
            let languageScreen = storyboard.instantiateViewController(withIdentifier: Screens.language.rawValue)
            self.present(languageScreen, animated: true)
        default:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginScreen = storyboard.instantiateViewController(withIdentifier: Screens.login.rawValue)
            self.present(loginScreen, animated: true)
        }
    }
}
