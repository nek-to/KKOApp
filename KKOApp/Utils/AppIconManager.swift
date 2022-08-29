//
//  AppIconManager.swift
//  KKOApp
//
//  Created by VironIT on 29.08.22.
//

import UIKit

class AppIconManager {
    let application = UIApplication.shared
    
    enum AppIcon: String {
        case goldenIcon
        case blueberryIcon
        case cacaoIcon
        case cozyIcon
    }
    
    func changeAppIcon(to appIcon: AppIcon) {
        application.setAlternateIconName(appIcon.rawValue)
    }
    
}
