//
//  ProfilePicture.swift
//  KKOApp
//
//  Created by VironIT on 29.08.22.
//
import RealmSwift
import Foundation

class Profile: Object {
    @objc dynamic var user: String?
    @objc dynamic var email: String?
    @objc dynamic var phone: String?
    @objc dynamic var image: Data?
    
    override class func primaryKey() -> String? {
        return "email"
    }
}
