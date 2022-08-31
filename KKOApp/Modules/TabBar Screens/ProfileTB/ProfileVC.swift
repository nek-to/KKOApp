//
//  ProfileVC.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//
import RealmSwift
import UIKit
import SwiftUI

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
    private var storage = try! Realm()
    private var imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferenceTableView.delegate = self
        preferenceTableView.dataSource = self
        imagePicker.delegate = self
        config()
    }

    
    private func config() {
        // profile picture
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
        profilePictureImageView.layer.borderColor = UIColor.white.cgColor
        profilePictureImageView.layer.borderWidth = 3
        // background picture
        topImageView.layer.cornerRadius = 30
        // top image
        setupTopImage()
        // setup profile picture
        setupProfPic()
    }
    
    private func setupTopImage() {
            let image = storage.objects(TopImage.self).first?.image
            if let image = image {
                topImageView.image = UIImage(data: try! Data(contentsOf: URL(string: image) ?? URL(fileURLWithPath: "profile-back")))
        }
    }
    
    private func chooseWayForProfileImageSetup() {
        let alert = UIAlertController(title: "Setup profile picture", message: "What need to be user", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Use photo library", style: .default) {_ in
            self.openLibrary()
        })
        alert.addAction(UIAlertAction(title: "Use camera", style: .default) { _ in
            self.openCamera()
        })
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteProfilePicture()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    private func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
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
        try? storage.write {
            storage.delete(storage.objects(ProfilePicture.self))
        }
        profilePictureImageView.image = UIImage()
    }
    
    private func setupProfPic() {
        let image = storage.objects(ProfilePicture.self).first?.image
        print(storage.objects(ProfilePicture.self))
            if let image = image {
                profilePictureImageView.image = UIImage(data: image)
        }
    }
    
    private func saveProfPic(_ image: UIImage) {
        let data = Data(image.jpegData(compressionQuality: 0.5)!)
        let profPic = ProfilePicture()
        profPic.image = data
        try! storage.write {
            storage.delete(storage.objects(ProfilePicture.self))
            storage.add(profPic)
        }
    }
    
    @IBAction func changeProfilePic(_ sender: UITapGestureRecognizer) {
        chooseWayForProfileImageSetup()
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
        try? storage.write {
            storage.delete(storage.objects(TopImage.self))
            topImage.image = imageUrl
            storage.add(topImage)
        }
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
        let preference = preferences.elements[indexPath.row]
        preferenceCell.configureCell(preference)
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

extension ProfileVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
     //You will get cropped image here..
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
         {
             self.profilePictureImageView.image = image
             saveProfPic(image)
         }
    }
}

extension ProfileVC: UINavigationControllerDelegate {
}


