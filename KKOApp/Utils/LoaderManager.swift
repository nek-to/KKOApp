//
//  LoaderManager.swift
//  KKOApp
//
//  Created by VironIT on 2.09.22.
//
import RealmSwift
import Foundation

final class LoaderManager {
    private let storage = try! Realm()

    
    func loadCoffeeInStorage() {
        var arrayRoot: NSArray?
        if let path = Bundle.main.path(forResource: "Coffee", ofType: "plist") {
            arrayRoot = NSArray(contentsOfFile: path)
        }
        
        if let array = arrayRoot {
            let arrayList: [NSDictionary] = array as! [NSDictionary]
            arrayList.forEach {
                let coffee = Coffee()
                coffee.name = $0["title"] as! String
                coffee.descript = $0["description"] as! String
                coffee.price = $0["price"] as! Int
                coffee.imageName =  $0["image"]  as! String
                coffee.like =  $0["like"] as! Bool
                coffee.time =  $0["time"] as! Double
                try? storage.write {
                    storage.add(coffee)
                }
            }
        }
    }
}
