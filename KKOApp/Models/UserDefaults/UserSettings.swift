//
//  UserSettings.swift
//  KKOApp
//
//  Created by VironIT on 1.09.22.
//

import Foundation

final class UserSettings {
    static var coffeeshopAddress: String! {
        get {
            return UserDefaults.standard.string(forKey: "address")
        } set {
            let defaults = UserDefaults.standard
            if let address = newValue {
                defaults.set(address, forKey: "address")
            } else {
                self.coffeeshopAddress = "улица Леонида Левина, 2"
            }
        }
    }
}
