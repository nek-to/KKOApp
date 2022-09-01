//
//  PurcaseVC.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//
import RealmSwift
import UIKit

class PurcaseVC: UIViewController {
    @IBOutlet weak var orderTableView: UITableView!
    
    private var storage = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }

    
    private func config() {
        // view controller
        purcaseVC.delegate = self
        purcaseVC.prefersGrabberVisible = true
        // register purcase cell
        orderTableView.register(UINib(nibName: "PurcaseTVCell", bundle: nil), forCellReuseIdentifier: "purcaseCell")
        // table view
        orderTableView.delegate = self
        orderTableView.dataSource = self
    }
}

extension PurcaseVC: UITableViewDelegate {
}

extension PurcaseVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storage.objects(Purcase.self).count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let buyedCoffees = storage.objects(Purcase.self)
        let coffee = buyedCoffees[indexPath.row]
        let purcaseCell = tableView.dequeueReusableCell(withIdentifier: "purcaseCell") as! PurcaseTVCell
        brewingCoffee(coffee, purcaseCell)
        saveBrewedCoffee(coffee)
        purcaseCell.configureCell(coffee)
        return purcaseCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
    
    private func saveBrewedCoffee(_ coffee: Purcase) {
        try! storage.write{
            coffee.showed = true
        }
    }
    
    private func brewingCoffee(_ coffee: Purcase, _ cell: PurcaseTVCell) {
        if !coffee.showed {
            cell.animateBrewingCoffee(coffee)
        } else {
            cell.coffeeBrewed()
        }
    }
}

extension PurcaseVC: UISheetPresentationControllerDelegate {
    private var purcaseVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}
