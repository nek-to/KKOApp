//
//  NewsStorage.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

class NewsStorage {
    var elements = [NewsItem]()
    
    static var shared = NewsStorage()
    
    private init() {
                var arrayRoot: NSArray?
        if let path = Bundle.main.path(forResource: "News", ofType: "plist") {
            arrayRoot = NSArray(contentsOfFile: path)
        }
        
        if let array = arrayRoot {
            let arrayList:[NSDictionary] = array as! [NSDictionary]
            arrayList.forEach {
                let news: NewsItem = .init(title: $0["title"] as! String,
                                           description: $0["description"] as! String,
                                           date: $0["date"] as! String,
                                           image: $0["image"] as! String,
                                           id: $0["id"] as! UInt8)
                elements.append(news)
            }
        }
    }
}
