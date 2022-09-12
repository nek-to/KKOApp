//
//  WidgetWeather.swift
//  KKOApp
//
//  Created by VironIT on 12.09.22.
//

import Foundation

struct WidgetWeather {
    var temp: String?
    var icon: String?
    var coffeeName: String?
    var coffeeImage: String?
    
    init(temp: String? = nil,
         icon: String? = nil,
         coffeeName: String? = nil,
         coffeeImage: String? = nil) {
        self.temp = temp
        self.icon = icon
        self.coffeeName = coffeeName
        self.coffeeImage = coffeeImage
    }
}
