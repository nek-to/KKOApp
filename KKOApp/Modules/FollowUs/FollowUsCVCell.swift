//
//  FollowUsCVCell.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

class FollowUsCVCell: UICollectionViewCell {
    @IBOutlet weak var peopleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        peopleImageView.layer.cornerRadius = 25
    }
}
