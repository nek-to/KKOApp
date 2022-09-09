//
//  PaymentVC.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//
import RealmSwift
import UIKit

final class PaymentVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var cardTableView: UITableView!
    @IBOutlet private weak var addCardButton: UIButton!
    
    // MARK: - Properties
    private var cards: Results<CreditCard>?
    private lazy var storage = try! Realm()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cardTableView.dataSource = self
        cardTableView.delegate = self
        config()
    }
    
    // MARK: - Setup
    private func config() {
        // add card button
        addCardButton.layer.borderWidth = 3
        addCardButton.layer.borderColor = #colorLiteral(red: 0.8207221627, green: 0.4692305923, blue: 0.257660836, alpha: 1)
        addCardButton.layer.cornerRadius = 15
        addCardButton.backgroundColor = .darkGray
        // card cell
        cardTableView.register(UINib(nibName: "CardTVCell", bundle: nil), forCellReuseIdentifier: "cardCell")
        // reloader
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCardView), name: Notification.Name(rawValue: "reloadCards"), object: nil)
        // view grabber
        
        paymentVC.delegate = self
        paymentVC.prefersGrabberVisible = true
    }
    
    // MARK: - Actions
    @objc private func reloadCardView() {
        self.cardTableView.reloadData()
    }
    
    @IBAction private func toAddCardScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "AddCard", bundle: nil)
        let addCardScreen = storyboard.instantiateViewController(withIdentifier: Screens.addCard.rawValue)
        present(addCardScreen, animated: true)
    }
    
}

    // MARK: - Extensions
    // MARK: UITableViewDelegate
extension PaymentVC: UITableViewDelegate {
}

    // MARK: UITableViewDataSource
extension PaymentVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storage.objects(CreditCard.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configCardCell(indexPath)
    }
    
    private func configCardCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cards = storage.objects(CreditCard.self)
        let card = cards[indexPath.row]
        let cardCell = cardTableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardTVCell
        cardCell.configureCell(card)
        cardCell.selectionStyle = .none
        return cardCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        260
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.cards = storage.objects(CreditCard.self)
            if let card = cards?[indexPath.row] {
                try? storage.write {
                    storage.delete(card)
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

    // MARK: UISheetPresentationControllerDelegate
extension PaymentVC: UISheetPresentationControllerDelegate {
    private var paymentVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}
