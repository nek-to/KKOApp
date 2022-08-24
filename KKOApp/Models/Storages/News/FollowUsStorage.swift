//
//  FollowUsStorage.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

class FollowUsStorage {
    var image: [UIImage?]?
    
    static var shared = FollowUsStorage()
    
    private init() {
        self.image = Array(1...16).compactMap {
            UIImage(named: "followus\($0)")
        }

        self.image = self.image?
            .compactMap { $0?.resizeImage(image: $0!, targetSize: .init(width: 300, height: 300)) }
        }
}
