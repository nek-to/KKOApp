//
//  CouponStorage.swift
//  KKOApp
//
//  Created by VironIT on 23.08.22.
//

import UIKit

class CouponeStorage {
    var couponsImage: [UIImage?]?
    
    static var shared = CouponeStorage()
    
    private init() {
        self.couponsImage = [UIImage(named: "coupon1"),
                             UIImage(named: "coupon2"),
                             UIImage(named: "coupon3"),
                             UIImage(named: "coupon4"),
                             UIImage(named: "coupon5"),
                             UIImage(named: "coupon6")
        ]
        self.couponsImage = self.couponsImage?
            .compactMap{ $0?.resizeImage(image: $0! , targetSize: .init(width: 300, height: 300))}
    }
}
