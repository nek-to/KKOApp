//
//  NewsStorage.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

class NewsStorage {
    var title: [String]?
    var description: [String]?
    var image: [String]?
    var date: [String]?
    var images: [UIImage?]?
    
    static var shared = NewsStorage()
    
    private init() {
        self.title = ["Follow us", "Add animation to app", "Ptotection", "We are on Map!"]
        self.description = ["Share photos from our coffee shop on social networks, tag us and get a coupon for free coffee!",
                            "We are add some animations in our app",
                            "Soon we will have a Touch/Face ID function",
                            "We're working on adding a map to our app so you can easily find us anywhere in the city!"]
        self.image = ["news1", "news2", "news3", "news4"]
        self.date = ["07.08", "08.08", "09.08", "09.08"]
        self.images = [.init(named: "news1"),
                       .init(named: "news2"),
                       .init(named: "news3"),
                       .init(named: "news4") ]

        self.images = self.images?
            .compactMap { $0?.resizeImage(image: $0!, targetSize: .init(width: 500, height: 500)) }
    }
}
