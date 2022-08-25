//
//  PreferenceStorage.swift
//  KKOApp
//
//  Created by VironIT on 25.08.22.
//

import Foundation

class PreferenceStorage {
    var elements: [PreferenceItem] = []
    
    static var shared = PreferenceStorage()
    
    private init() {
                var arrayRoot: NSArray?
                if let path = Bundle.main.path(forResource: "Preference", ofType: "plist") {
                    arrayRoot = NSArray(contentsOfFile: path)
                }
        
        if let array = arrayRoot {
            let arrayList:[NSDictionary] = array as! [NSDictionary]
            arrayList.forEach {
                let preference: PreferenceItem = .init(title: $0["title"] as! String,
                                                   icon: $0["icon"] as! String)
                elements.append(preference)
            }
        }
    }
}
