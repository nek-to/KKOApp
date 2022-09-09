//
//  CouponStorage.swift
//  KKOApp
//
//  Created by VironIT on 23.08.22.
//

import UIKit

final class CouponeStorage {
    var couponsImage: [UIImage?]?
    
    static var shared = CouponeStorage()
    
    private init() {
        self.couponsImage = Array(1...4).compactMap {
            UIImage(named: "coupon\($0)")
        }
    }
}
