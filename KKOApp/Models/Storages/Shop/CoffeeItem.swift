//
//  Coffee.swift
//  KKOApp
//
//  Created by VironIT on 23.08.22.
//

import UIKit

class CoffeeItem {
    var name: String
    var description: String
    var price: UInt
    var imageName: String
    var like: Bool
    
    init(name: String, description: String, price: UInt, imageName: String, like: Bool) {
        self.name = name
        self.description = description
        self.price = price
        self.imageName = imageName
        self.like = like
    }
}
