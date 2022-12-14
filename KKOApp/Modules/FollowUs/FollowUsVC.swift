//
//  FollowUsVC.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit
import Lottie

final class FollowUsVC: UICollectionViewController {
    // MARK: - Properties
    private var followUs = FollowUsStorage.shared
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewLayout()
    }
    
    // MARK: - Setup
    private func setupCollectionViewLayout() {
        let customLayuot = CustomLayout()
        customLayuot.delegate = self
        collectionView.collectionViewLayout = customLayuot
    }
    
    // MARK: - Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followUs.image!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "followCell", for: indexPath) as! FollowUsCVCell
        cell.configureCell(followUs, indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        let transtorm = CATransform3DTranslate(CATransform3DIdentity, -200, 100, 0)
        cell.layer.transform = transtorm
        
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
}

    // MARK: - Extensions: CustomLayoutDelegate
extension FollowUsVC: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return followUs.image![indexPath.item]!.size
    }
}
