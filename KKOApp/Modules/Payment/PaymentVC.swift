//
//  PaymentVC.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//
import RealmSwift
import UIKit

class PaymentVC: UIViewController {
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var addCardButton: UIButton!
    
//    private var card: CreditCard?
    private var cards: Results<CreditCard>?
    private lazy var cardStorage = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardTableView.dataSource = self
        cardTableView.delegate = self
        config()
    }
    
    
    private func config() {
        // add card button
        addCardButton.layer.borderWidth = 3
        addCardButton.layer.borderColor = #colorLiteral(red: 0.8207221627, green: 0.4692305923, blue: 0.257660836, alpha: 1)
        addCardButton.layer.cornerRadius = 15
        addCardButton.backgroundColor = .darkGray
        // card cell
        cardTableView.register(UINib(nibName: "CardTVCell", bundle: nil), forCellReuseIdentifier: "cardCell")
        // reloader
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadCardView), name: NSNotification.Name(rawValue: "reloader"), object: nil)
    }
    
    @objc private func reloadCardView() {
        self.cardTableView.reloadData()
    }
    
    @IBAction func toAddCardScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "AddCard", bundle: nil)
        let addCardScreen = storyboard.instantiateViewController(withIdentifier: Screens.addCard.rawValue)
        present(addCardScreen, animated: true)
    }
    
}

extension PaymentVC: UITableViewDelegate {
}

extension PaymentVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cardStorage.objects(CreditCard.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configCardCell(indexPath)
    }
    
    private func configCardCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cards = cardStorage.objects(CreditCard.self)
        let card = cards[indexPath.row]
        let cardCell = cardTableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardTVCell
        cardCell.numberLabel.text = card.number
        cardCell.dateLabel.text = card.date
        cardCell.nameLabel.text = card.name
        cardCell.fonImageView.image = UIImage(data: try! Data(contentsOf: URL(string: card.fonImage)!))
        cardCell.selectionStyle = .none
        return cardCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        260
    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.cards = cardStorage.objects(CreditCard.self)
            if let card = cards?[indexPath.row] {
                try? cardStorage.write {
                    cardStorage.delete(card)
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

extension PaymentVC: UISheetPresentationControllerDelegate {
    private var paymentVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}
