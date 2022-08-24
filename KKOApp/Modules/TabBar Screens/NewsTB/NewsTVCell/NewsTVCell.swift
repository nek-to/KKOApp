//
//  NewsTVCell.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

class NewsTVCell: UITableViewCell {

    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var item: NewsItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageImageView.layer.cornerRadius = 30
    }
    
    internal func configure(_ news: NewsItem) {
        item = news
        titleLabel.text = item?.title
        descriptionLabel.text = item?.description
        dateLabel.text = item?.date
        imageImageView.image = UIImage().resizeImage(image: .init(named: item!.image)!,
                                                     targetSize: .init(width: 300, height: 300))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
