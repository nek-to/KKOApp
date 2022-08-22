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
            self.image = [UIImage(named:"followus1"),
                          UIImage(named:"followus2"),
                          UIImage(named:"followus3"),
                          UIImage(named:"followus4"),
                          UIImage(named:"followus5"),
                          UIImage(named:"followus6"),
                          UIImage(named:"followus7"),
                          UIImage(named:"followus8"),
                          UIImage(named:"followus9"),
                          UIImage(named:"followus10"),
                          UIImage(named:"followus11"),
                          UIImage(named:"followus12"),
                          UIImage(named:"followus13"),
                          UIImage(named:"followus14"),
                          UIImage(named:"followus15"),
                          UIImage(named:"followus16")
                          ]

        self.image = self.image?
            .compactMap { $0?.resizeImage(image: $0!, targetSize: .init(width: 300, height: 300)) }
        }
}
