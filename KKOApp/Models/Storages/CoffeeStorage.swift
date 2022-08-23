//
//  CoffeeStorage.swift
//  KKOApp
//
//  Created by VironIT on 23.08.22.
//

import UIKit

class CoffeeStorage {
    var name: [String]
    var description: [String]
    var price: [String]
    var imageName: [UIImage]
    var like: [Bool]
    var elements: [CoffeeItem] = []
    
    static var shared = CoffeeStorage()
    
    private init() {
        self.name = ["Espresso", "Flavoured Latte", "Flat White", "Bean Bar Latte", "Piccolo Latte", "Cappuccino", "Vienna", "Snow Hot Chocolate", "Starbucks Caramel Frappuccino", "Chocolate Coffee Kiss", "Coffee Shake", "Flat White Martini"]
        self.description = ["A single shot of espresso",
                            "Latte topped with sweetened flavoured syrup (flavours include Hazelnut, Caramel, Vanilla & Irish Cream)",
                            "A double shot of espresso with flat steamed milk",
                            "A double shot of espresso with steamed milk a small layer of foam and a special sweetened coffee flavoured syrup",
                            "A single shot of espresso with a small layer of foam",
                            "A double shot of espresso with equal parts steamed milk and foam",
                            "A long black, topped with whipped cream",
                            "Rich white chocolate with steamed milk and a small layer of foam",
                            "Made with ice, coffee, and flavored syrups, the beverage's flavor and texture is somewhere between a milkshake and an iced coffee",
                            "This is a sweet coffee drink, for all you coffee lovers who want an extra kick in your java",
                            "This is a blended-coffee treat much like an iced cappuccino you might buy at a expensive restaurant",
                            "This espresso martini with Original Irish Cream tastes as good as it looks"
        ]
        self.price = ["2$", "5$","4$","6$","4$","3$","2$","6$","5$","2$","4$","3$"]
        self.imageName = [UIImage(named: "coffee1")!,
                          UIImage(named: "coffee2")!,
                          UIImage(named: "coffee3")!,
                          UIImage(named: "coffee4")!,
                          UIImage(named: "coffee5")!,
                          UIImage(named: "coffee6")!,
                          UIImage(named: "coffee7")!,
                          UIImage(named: "coffee8")!,
                          UIImage(named: "coffee9")!,
                          UIImage(named: "coffee10")!,
                          UIImage(named: "coffee11")!,
                          UIImage(named: "coffee12")!]
        self.imageName = self.imageName
            .compactMap{ $0.resizeImage(image: $0, targetSize: .init(width: 200, height: 200))}
        self.like = .init(repeating: false, count: 12)
        
        var arrayRoot: NSArray?
        if let path = Bundle.main.path(forResource: "Coffee", ofType: "plist") {
            arrayRoot = NSArray(contentsOfFile: path)
            print("path \(path)")
        }

        if let array = arrayRoot {
            var arrayList:[NSDictionary] = arrayRoot as! [NSDictionary]
            arrayList.forEach {
                let coffee: CoffeeItem = .init(name: $0["title"] as! String,
                                               description: $0["description"] as! String,
                                               price: $0["price"] as! Int,
                                               imageName: $0["image"]  as! String,
                                               like: $0["like"] as! Bool)
                print(coffee)
            }
            // print("plist \(arrayList)")
        } else {
            print("no root")
        }
    }
}
