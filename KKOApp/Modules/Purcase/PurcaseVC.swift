//
//  PurcaseVC.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//
import RealmSwift
import UIKit

class PurcaseVC: UIViewController {
    @IBOutlet weak var showAllHistoryButton: UIButton!
    @IBOutlet weak var orderTableView: UITableView!
    
    private var buyedCoffee = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTableView.delegate = self
        orderTableView.dataSource = self
        config()
    }
    
    private func config() {
        orderTableView.register(UINib(nibName: "PurcaseTVCell", bundle: nil), forCellReuseIdentifier: "purcaseCell")
    }
}

extension PurcaseVC: UITableViewDelegate {
}

extension PurcaseVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        buyedCoffee.objects(Purcase.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let buyedCoffees = buyedCoffee.objects(Purcase.self)
        let coffee = buyedCoffees[indexPath.row]
        let purcaseCell = tableView.dequeueReusableCell(withIdentifier: "purcaseCell") as! PurcaseTVCell
        purcaseCell.configureCell(coffee)
        

        return purcaseCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
}
