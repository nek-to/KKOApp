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
    var price: Int
    var imageName: String
    var like: Bool
    var time: Int
    
    init(name: String, description: String, price: Int, imageName: String, like: Bool, time: Int) {
        self.name = name
        self.description = description
        self.price = price
        self.imageName = imageName
        self.like = like
        self.time = time
    }
}
