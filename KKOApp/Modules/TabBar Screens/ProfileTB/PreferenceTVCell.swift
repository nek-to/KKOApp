//
//  PreferenceTV.swift
//  KKOApp
//
//  Created by VironIT on 25.08.22.
//

import UIKit

class PreferenceTVCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var preferenceLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ preference: PreferenceItem) {
            iconImageView.image = UIImage(named: preference.icon)
            preferenceLabel.text = preference.title
    }
}
