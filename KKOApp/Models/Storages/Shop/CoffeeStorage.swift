//
//  CoffeeStorage.swift
//  KKOApp
//
//  Created by VironIT on 23.08.22.
//

import UIKit

class CoffeeStorage {
    var elements: [CoffeeItem] = []
    
    static var shared = CoffeeStorage()
    
    private init() {
                var arrayRoot: NSArray?
                if let path = Bundle.main.path(forResource: "Coffee", ofType: "plist") {
                    arrayRoot = NSArray(contentsOfFile: path)
                }
        
        if let array = arrayRoot {
            let arrayList:[NSDictionary] = array as! [NSDictionary]
            arrayList.forEach {
                let coffee: CoffeeItem = .init(name: $0["title"] as! String,
                                               description: $0["description"] as! String,
                                               price: $0["price"] as! UInt,
                                               imageName: $0["image"]  as! String,
                                               like: $0["like"] as! Bool)
                elements.append(coffee)
            }
        }
    }
}
