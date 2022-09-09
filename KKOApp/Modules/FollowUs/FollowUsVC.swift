//
//  FollowUsVC.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit
import Lottie

final class FollowUsVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var photoCollectionView: UICollectionView!
    @IBOutlet private weak var foneImage: UIImageView!
    
    // MARK: - Properties
    private var followUs = FollowUsStorage.shared
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewLayout()
        foneImage.image = .init().resizeImage(image: UIImage(named: "news1")!, targetSize: .init(width: 400, height: 400))
        foneImage.alpha = 0.3

        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
    }
    
    // MARK: - Setup
    private func setupCollectionViewLayout() {
        let customLayuot = CustomLayout()
        customLayuot.delegate = self
        photoCollectionView.collectionViewLayout = customLayuot
    }
    
}

    // MARK: - Extensions
    // MARK: CustomLayoutDelegate
extension FollowUsVC: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return followUs.image![indexPath.item]!.size
    }
}

    // MARK: UICollectionViewDataSource
extension FollowUsVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followUs.image!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "followCell", for: indexPath) as! FollowUsCVCell
        cell.configureCell(followUs, indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        let transtorm = CATransform3DTranslate(CATransform3DIdentity, -200, 100, 0)
        cell.layer.transform = transtorm
        
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
}

    // MARK: UICollectionViewDelegate
extension FollowUsVC: UICollectionViewDelegate {
}
