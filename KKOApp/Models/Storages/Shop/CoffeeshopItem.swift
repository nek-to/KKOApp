//
//  CoffeeshopItem.swift
//  KKOApp
//
//  Created by VironIT on 25.08.22.
//

import Foundation

class CoffeeshopItem {
    var address: String
    var name: String
    var latitude: Double
    var longitude: Double
    var icon: String
    
    init(address: String, name: String, latitude: Double, longitude: Double, icon: String) {
        self.address = address
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.icon = icon
    }
}
