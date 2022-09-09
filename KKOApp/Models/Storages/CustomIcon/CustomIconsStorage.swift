//
//  CustomIconsStorage.swift
//  KKOApp
//
//  Created by VironIT on 29.08.22.
//

import UIKit

final class CustomIconsStorage {
    var elements: [CustomIcon] = []
    
    static var shared = CustomIconsStorage()
    
    private init() {
                var arrayRoot: NSArray?
                if let path = Bundle.main.path(forResource: "CustomIcons", ofType: "plist") {
                    arrayRoot = NSArray(contentsOfFile: path)
                }
        
        if let array = arrayRoot {
            let arrayList: [NSDictionary] = array as! [NSDictionary]
            arrayList.forEach {
                let icons: CustomIcon = .init(title: $0["title"] as! String,
                                                   image: $0["image"] as! String)
                elements.append(icons)
            }
        }
    }
}
