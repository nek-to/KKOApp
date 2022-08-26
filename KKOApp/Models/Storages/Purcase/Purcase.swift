//
//  Purcase.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//
import RealmSwift
import Foundation

class Purcase: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var time: Int = 0
}
