//
//  CouponCVCell.swift
//  KKOApp
//
//  Created by VironIT on 23.08.22.
//

import UIKit

final class CouponCVCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var couponImageView: UIImageView!
    
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        couponImageView.layer.cornerRadius = 30
    }
    
    // MARK: - Setup
    func configureCollectCell(_ coupon: CouponeStorage, _ index: IndexPath) {
        couponImageView.image = coupon.couponsImage?[index.row]
    }
}
