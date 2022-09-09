//
//  PreferenceTV.swift
//  KKOApp
//
//  Created by VironIT on 25.08.22.
//

import UIKit

final class PreferenceTVCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var preferenceLabel: UILabel!
    
    // MARK: - Cell Life Cycle
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setup
    func configureCell(_ preference: PreferenceItem) {
            iconImageView.image = UIImage(named: preference.icon)
            preferenceLabel.text = preference.title
    }
}
