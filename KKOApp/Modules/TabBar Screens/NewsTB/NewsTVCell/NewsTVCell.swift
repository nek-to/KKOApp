//
//  NewsTVCell.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

final class NewsTVCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var imageImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        imageImageView.layer.cornerRadius = 30
    }
    
    // MARK: - Setup
    func configure(_ news: NewsItem) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        dateLabel.text = news.date
        imageImageView.image = UIImage().resizeImage(image: .init(named: news.image)!,
                                                     targetSize: .init(width: 300, height: 300))
    }
}
