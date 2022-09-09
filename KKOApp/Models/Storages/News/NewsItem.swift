//
//  NewsItem.swift
//  KKOApp
//
//  Created by Kolya Gribok on 24.08.22.
//

import Foundation

final class NewsItem {
    var id: UInt8
    var title: String
    var description: String
    var image: String
    var date: String
    
    init(title: String, description: String, date: String, image: String, id: UInt8) {
        self.title = title
        self.description = description
        self.date = date
        self.image = image
        self.id = id
    }
}
