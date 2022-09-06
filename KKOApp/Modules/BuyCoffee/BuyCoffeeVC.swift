//
//  BuyCoffeeVC.swift
//  KKOApp
//
//  Created by Kolya Gribok on 24.08.22.
//
import UserNotifications
import RealmSwift
import UIKit
import SwiftUI

protocol CoffeeProtocol {
    var name: String { get set }
    var descript: String { get set }
    var price: Int { get set }
    var imageName: String { get set }
    var time: Double { get set }
}

class BuyCoffeeVC: UIViewController, CoffeeProtocol {
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeSButton: UIButton!
    @IBOutlet weak var sizeMButton: UIButton!
    @IBOutlet weak var sizeLButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var buttonsStack: UIStackView!
    @IBOutlet weak var backCardImageView: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    
    var name: String = ""
    var descript: String = ""
    var price: Int = 0
    var imageName: String = ""
    var time: Double = 0
    private var storage = try! Realm()
    private var notification = UNUserNotificationCenter.current()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        selection(sizeSButton)
        configure(title: name, descript: descript, price: price, image: imageName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        self.view.addGestureRecognizer(swipeRight)
    }


    private func configure(title: String, descript: String, price: Int, image: String) {
        titleLabel.text = title
        descriptionLabel.text = descript
        priceLabel.text = "\(price).0"
        coffeeImageView.image = UIImage().resizeImage(image: .init(named: image) ?? UIImage(), targetSize: .init(width: 400, height: 400))
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            self.navigationController?.popViewController(animated: true)
       }
    }
    
    private func config() {
        // card view
        cardView.alpha = 0.9
        cardView.layer.cornerRadius = 20
        // container view
        containerView.layer.cornerRadius = 20
        containerView.alpha = 1
        // coffee image view
        coffeeImageView.layer.cornerRadius = 20
        // buy button
        buyButton.layer.cornerRadius = 20
        // size S buttom
        sizeSButton.layer.cornerRadius = 20
        // size M buttom
        sizeMButton.layer.cornerRadius = 20
        // size L buttom
        sizeLButton.layer.cornerRadius = 20
        // back card image
        backCardImageView.layer.cornerRadius = 40
        // description view
        descriptionView.layer.cornerRadius = 20
    }
    
    private func selection(_ sender: UIButton) {
        sender.layer.borderWidth = 3
        sender.layer.borderColor = #colorLiteral(red: 0.8207221627, green: 0.4692305923, blue: 0.257660836, alpha: 1)
        sender.layer.backgroundColor = #colorLiteral(red: 0.02539518371, green: 0.02564662118, blue: 0.02564662118, alpha: 1)
    }
    
    private func deselection(_ sender: UIButton) {
        sender.layer.backgroundColor = #colorLiteral(red: 0.1239658703, green: 0.1239658703, blue: 0.1239658703, alpha: 1)
        sender.layer.borderWidth = 0
    }
    
    private func saveBuyedCoffee() {
        let coffee = Purcase()
        guard !titleLabel.text!.isEmpty,
        !imageName.isEmpty else { return }
        coffee.title = titleLabel.text!
        coffee.image = imageName
        coffee.buyTiming = Date()
        coffee.time = time
        coffee.showed = false
        try? storage.write {
            storage.add(coffee)
        }
    }
    
    
    private func buttonPressed() {
        if buyButton.isTouchInside {
            buyButton.backgroundColor = #colorLiteral(red: 0.5821276091, green: 0.3368276301, blue: 0.185697452, alpha: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.buyButton.backgroundColor = #colorLiteral(red: 0.8207221627, green: 0.4692305923, blue: 0.257660836, alpha: 1)
            }
        }
    }
    
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Your coffee is ready"
        guard let address = UserSettings.coffeeshopAddress else  { return }
        guard !address.isEmpty else {
            return content.body = "ulica Leonida Levina, 2"
        }
        content.body = "Your \(name) is waiting for you at \(address)"

        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(time), repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request)
        notification.add(request)
    }
    

    
    @IBAction private func chooseSize(_ sender: UIButton) {
        if sender.tag == 0 {
            priceLabel.text = String(Double(price))
            selection(sender)
            deselection(sizeMButton)
            deselection(sizeLButton)
        } else if sender.tag == 1 {
            priceLabel.text = String(Double(price) + 1.5)
            selection(sender)
            deselection(sizeSButton)
            deselection(sizeLButton)
        } else {
            priceLabel.text = String(Double(price) + 2.5)
            selection(sender)
            deselection(sizeSButton)
            deselection(sizeMButton)
        }
    }
    
    @IBAction private func buyCoffee(_ sender: UIButton) {
        saveBuyedCoffee()
        buttonPressed()
        sendNotification()
    }
}
