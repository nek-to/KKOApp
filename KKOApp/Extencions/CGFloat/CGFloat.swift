//
//  CGFloat.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
