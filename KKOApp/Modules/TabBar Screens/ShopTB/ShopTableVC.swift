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
    
    private var filteredCoffee = [CoffeeStorage]()
    private var coffee = CoffeeStorage.shared
    private var coupone = CouponeStorage.shared
    private let okey = AnimationView(name: "ok")
    private var animate = true

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        couponsCollectionView.delegate = self
        couponsCollectionView.dataSource = self
        lottieView.isHidden = true
        foneImageView.layer.cornerRadius = 40
        
        couponsCollectionView.register(UINib(nibName: "CouponCVCell", bundle: nil), forCellWithReuseIdentifier: "couponCell")
        tableView.register(UINib(nibName: "CoffeeTVCell", bundle: nil), forCellReuseIdentifier: "coffeeCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffee.name.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return returnConfigCell(for: indexPath)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    private func returnConfigCell(for indexPath: IndexPath) -> UITableViewCell {
        let cellCoffee = tableView.dequeueReusableCell(withIdentifier: "coffeeCell") as! CoffeeTVCell
        // cellCoffee.configure(<#T##coffee: Coffee##Coffee#>)
        cellCoffee.titleLabel.text = coffee.name[indexPath.row]
        cellCoffee.descritionLabel.text = coffee.description[indexPath.row]
        cellCoffee.selectionStyle = .none
        cellCoffee.priceLabel.text = coffee.price[indexPath.row]
        cellCoffee.coffeeImage.image = coffee.imageName[indexPath.row]
        if cellCoffee.likeIndicator {
            coffee.like[indexPath.row] = true
        }
        cellCoffee.likeButton.isSelected = coffee.like[indexPath.row]
        return cellCoffee
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
    }
}
