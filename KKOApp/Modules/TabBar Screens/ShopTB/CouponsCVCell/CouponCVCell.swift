//
//  CouponCVCell.swift
//  KKOApp
//
//  Created by VironIT on 23.08.22.
//

import UIKit

class CouponCVCell: UICollectionViewCell {
    @IBOutlet internal weak var couponImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        couponImageView.layer.cornerRadius = 30
    }

}
