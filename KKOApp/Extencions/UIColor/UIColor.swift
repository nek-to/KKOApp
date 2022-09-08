//
//  UIColor.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red: .random(),
           green: .random(),
           blue: .random(),
           alpha: 1.0
        )
    }
}
