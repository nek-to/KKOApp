//
//  Coffee.swift
//  KKOApp
//
//  Created by VironIT on 2.09.22.
//
import Foundation
import RealmSwift

final class Coffee: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var descript: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var imageName: String = ""
    @objc dynamic var time: Double = 0
    @objc dynamic var like: Bool = false
    
    override class func primaryKey() -> String? {
        return "name"
    }
}
