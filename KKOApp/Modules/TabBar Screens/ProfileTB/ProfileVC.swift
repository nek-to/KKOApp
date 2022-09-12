//
//  ProfileVC.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//
import FirebaseAuth
import RealmSwift
import UIKit
import SwiftUI

final class ProfileVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var topImageView: UIImageView!
    @IBOutlet private weak var profilePictureImageView: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var phone: UILabel!
    @IBOutlet private weak var address: UILabel!
    @IBOutlet private weak var preferenceTableView: UITableView!
    @IBOutlet private weak var protectionSwitch: UISwitch!
    @IBOutlet private weak var protectionStateImageView: UIImageView!
    @IBOutlet private weak var weatherTemperatureLabel: UILabel!
    @IBOutlet private weak var weatherIconImage: UIImageView!
    
    // MARK: - Properties
    private var preferences = PreferenceStorage.shared
    private var imageUrl = ""
    private var storage = try! Realm()
    private var imagePicker = UIImagePickerController()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        preferenceTableView.delegate = self
        preferenceTableView.dataSource = self
        imagePicker.delegate = self
        config()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAddress), name: NSNotification.Name(rawValue: "reloadAddress"), object: nil)
    }
    
    // MARK: - Setup
    private func config() {
        // profile picture
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
        profilePictureImageView.layer.borderColor = UIColor.white.cgColor
        profilePictureImageView.layer.borderWidth = 3
        // background picture
        topImageView.layer.cornerRadius = 30
        // top image
        setupTopImage()
        // user setup
        userSetup()
        // weather
        getWeatherFromNetwork()
        // protection switch
        if let userEmail = FirebaseAuth.Auth.auth().currentUser?.email {
            if let switcher = storage.object(ofType: Profile.self, forPrimaryKey: userEmail) {
                protectionSwitch.isOn = switcher.protectionState
                initProtectionImageState(switcher.protectionState)
            }
        }
        // setup address
        guard let coffeeShop = UserSettings.coffeeshopAddress, !coffeeShop.isEmpty else {
            return address.text = "ulica Leonida Levina, 2"
        }
        address.text = coffeeShop
    }
    
    private func userSetup() {
        if let userEmail = FirebaseAuth.Auth.auth().currentUser?.email {
            if let user = storage.object(ofType: Profile.self, forPrimaryKey: userEmail) {
                name.text = user.user
                phone.text = user.phone
                if let image = user.image {
                    profilePictureImageView.image = UIImage(data: image)
                }
            }
        }
    }
    
    private func setupTopImage() {
        guard let imageFromStore = storage.objects(TopImage.self).first?.image, !imageFromStore.isEmpty else {
            return loadFonImage()
        }
        let image = UIImage(data: try! Data(contentsOf: URL(string: imageFromStore)!))
        topImageView.image = image
    }
    
    // MARK: - Methods
    private func loadFonImage() {
        UnsplashNetworkManager.getImageFromStock { [weak self] url in
            if let url = url {
                self?.imageUrl = url
                self?.saveTopImage(url: url)
                if let data = try? Data(contentsOf: URL(string: url)!) {
                    self?.topImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func saveTopImage(url: String) {
        let topImage = TopImage()
        try? storage.write {
            storage.delete(storage.objects(TopImage.self))
            topImage.image = imageUrl
            storage.add(topImage)
        }
    }
    
    private func initProtectionImageState(_ state: Bool) {
        let imageName = state ? "protect" : "delete"
        protectionStateImageView.image = UIImage(named: imageName)
    }
    
    private func chooseWayForProfileImageSetup() {
        let alert = UIAlertController(title: "Setup profile picture", message: "What need to be user", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Use photo library", style: .default) {[weak self] _ in
            self?.openLibrary()
        })
        alert.addAction(UIAlertAction(title: "Use camera", style: .default) { [weak self] _ in
            self?.openCamera()
        })
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteProfilePicture()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You have no permission to use camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openLibrary() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func deleteProfilePicture() {
        if let userEmail = FirebaseAuth.Auth.auth().currentUser?.email {
            try! storage.write {
                storage.delete(storage.object(ofType: Profile.self, forPrimaryKey: userEmail)!)
            }
        }
        profilePictureImageView.image = UIImage()
    }
    
    private func saveProfPic(_ image: UIImage) {
        let data = Data(image.jpegData(compressionQuality: 0.5)!)
        if let userEmail = FirebaseAuth.Auth.auth().currentUser?.email {
            let profile = storage.object(ofType: Profile.self, forPrimaryKey: userEmail)
            try! storage.write {
                profile?.image = data
            }
        }
    }
    
    private func getWeatherFromNetwork() {
        WeatherNetworkManager.getWeather { [weak self] weather in
            if let weather = weather {
                let temp = String(weather.data.first?.temp ?? 0)
                self?.weatherTemperatureLabel.text = "\(temp)°C"
                guard let image = weather.data.first?.weather.icon else { return }
                self?.weatherIconImage.image = UIImage(named: image)
            }
        }
    }
    
    // MARK: - Actions
    @objc private func reloadAddress() {
        address.text = UserSettings.coffeeshopAddress
    }
    
    @IBAction private func changeProfilePic(_ sender: UITapGestureRecognizer) {
        chooseWayForProfileImageSetup()
    }
    
    @IBAction private func chooseAdress(_ sender: UITapGestureRecognizer) {
        let toAddressCreen = UIStoryboard(name: Storyboards.address.rawValue, bundle: nil).instantiateViewController(withIdentifier: Screens.address.rawValue)
        self.present(toAddressCreen, animated: true)
    }
    
    @IBAction private func reloadFonImage() {
        loadFonImage()
    }
    
    @IBAction private func protectionSwitch(_ sender: UISwitch) {
        if let userEmail = FirebaseAuth.Auth.auth().currentUser?.email {
            let profile = storage.object(ofType: Profile.self, forPrimaryKey: userEmail)
            try! storage.write {
                profile?.protectionState = protectionSwitch.isOn
            }
        }
        initProtectionImageState(protectionSwitch.isOn)
    }
}

    // MARK: - Extensions
    // MARK: UITableViewDelegate
extension ProfileVC: UITableViewDelegate {
}

    // MARK: UITableViewDataSource
extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        preferences.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let preferenceCell = tableView.dequeueReusableCell(withIdentifier: "preferenceCell") as! PreferenceTVCell
        let preference = preferences.elements[indexPath.row]
        preferenceCell.configureCell(preference)
        preferenceCell.selectionStyle = .none
        preferenceCell.accessoryType = .disclosureIndicator
        return preferenceCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = preferences.elements[indexPath.row].title
        selectPreferenceOption(option)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    private func selectPreferenceOption(_ option: String) {
        var storyboard: Storyboards = .map
        var screen: Screens = .map
        switch option {
        case Preferences.location.rawValue:
            storyboard = .map
            screen = .map
        case Preferences.payment.rawValue:
            storyboard = .payment
            screen = .payment
        case Preferences.purcase.rawValue:
            storyboard = .purcase
            screen = .purcase
        case Preferences.icon.rawValue:
            storyboard = .icon
            screen = .icon
        case Preferences.logout.rawValue:
            storyboard = .login
            screen = .login
            try? FirebaseAuth.Auth.auth().signOut()
        default:
            break
        }
        let toScreen = UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: screen.rawValue)
        present(toScreen, animated: true)
    }
}

    // MARK: UIImagePickerControllerDelegate
extension ProfileVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
             self.profilePictureImageView.image = image
             saveProfPic(image)
         }
    }
}

    // MARK: UINavigationControllerDelegate
extension ProfileVC: UINavigationControllerDelegate {
}
