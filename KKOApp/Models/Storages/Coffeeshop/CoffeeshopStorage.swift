//
//  CoffeeshopStorage.swift
//  KKOApp
//
//  Created by VironIT on 25.08.22.
//

import Foundation

class CoffeeshopStorage {
    var elements: [CoffeeshopItem] = []
    
    static var shared = CoffeeshopStorage()
    
    private init() {
                var arrayRoot: NSArray?
                if let path = Bundle.main.path(forResource: "Coffeeshops", ofType: "plist") {
                    arrayRoot = NSArray(contentsOfFile: path)
                }
        
        if let array = arrayRoot {
            let arrayList: [NSDictionary] = array as! [NSDictionary]
            arrayList.forEach {
                let coffeeshop: CoffeeshopItem = .init(address: $0["address"] as! String,
                                                   name: $0["name"] as! String,
                                                   latitude: $0["latitude"] as! Double,
                                                   longitude: $0["longitude"] as! Double,
                                                   icon: $0["icon"] as! String)
                elements.append(coffeeshop)
            }
        }
    }
}
