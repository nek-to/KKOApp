//
//  FollowUsCVCell.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit
import SwiftUI

final class FollowUsCVCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var peopleImageView: UIImageView!
        
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        peopleImageView.layer.cornerRadius = 25
    }
    
    func configureCell(_ follow: FollowUsStorage, _ index: IndexPath) {
        peopleImageView.image = follow.image?[index.row]
    }
}
