//
//  ShopTableVC.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//
import Lottie
import UIKit

class ShopTableVC: UITableViewController {
    @IBOutlet weak var foneImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var couponsCollectionView: UICollectionView!
    @IBOutlet weak var lottieView: UIView!
    
    private var filteredCoffee = [CoffeeItem]()
    private var coffee = CoffeeStorage.shared
    private var coupone = CouponeStorage.shared
    private let okey = AnimationView(name: "ok")
    private var animate = true
    private var searchBarIsEmpty: Bool {
        guard let text = searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchBar.isFirstResponder && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        couponsCollectionView.delegate = self
        couponsCollectionView.dataSource = self
        config()
    }
    
    private func config() {
        // lottie view
        lottieView.isHidden = true
        // fone image
        foneImageView.layer.cornerRadius = 40
        // search bar
        searchBar.placeholder = "Search coffee"
        searchBar.autocapitalizationType = .none
        // coupons cell registration
        couponsCollectionView.register(UINib(nibName: "CouponCVCell", bundle: nil), forCellWithReuseIdentifier: "couponCell")
        // table cell registration
        tableView.register(UINib(nibName: "CoffeeTVCell", bundle: nil), forCellReuseIdentifier: "coffeeCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCoffee.count
        }
        return coffee.elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return returnConfigCell(for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "BuyCoffee", bundle: nil)
        var toBuyCoffee = storyboard.instantiateViewController(withIdentifier: Screens.buyCoffee.rawValue) as! CoffeeProtocol
        toBuyCoffee.name = coffee.elements[indexPath.row].name
        toBuyCoffee.descript = coffee.elements[indexPath.row].description
        toBuyCoffee.name = coffee.elements[indexPath.row].name
        toBuyCoffee.price = coffee.elements[indexPath.row].price
        toBuyCoffee.imageName = coffee.elements[indexPath.row].imageName
        navigationController?.pushViewController(toBuyCoffee as! UIViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    private func returnConfigCell(for indexPath: IndexPath) -> UITableViewCell {
        let coffeeCell = tableView.dequeueReusableCell(withIdentifier: "coffeeCell") as! CoffeeTVCell
        if isFiltering {
            coffeeCell.configure(filteredCoffee[indexPath.row])
            coffeeCell.selectionStyle = .none
            return coffeeCell
        }
        coffeeCell.configure(coffee.elements[indexPath.row])
        coffeeCell.selectionStyle = .none
        return coffeeCell
    }
}

extension ShopTableVC: UICollectionViewDelegate {
}

extension ShopTableVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coupone.couponsImage!.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let couponCell = collectionView.dequeueReusableCell(withReuseIdentifier: "couponCell", for: indexPath) as! CouponCVCell

        couponCell.couponImageView.image = coupone.couponsImage![indexPath.row]

        return couponCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lottieView.isHidden = false
        lottieAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            self?.okey.removeFromSuperview()
            self?.lottieView.isHidden = true
        }
    }
    
    private func lottieAnimation() {
        okey.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        okey.center = lottieView.center
        okey.contentMode = .scaleAspectFill
        okey.loopMode = .playOnce
        view.addSubview(okey)
        okey.play { complited in
            self.animate = false
        }
    }
}

extension ShopTableVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 128)
    }
}

extension ShopTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCoffee = coffee.elements.filter { (coffee: CoffeeItem) -> Bool in
            return coffee.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}
