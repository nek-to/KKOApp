//
//  ProfilePicture.swift
//  KKOApp
//
//  Created by VironIT on 29.08.22.
//
import RealmSwift
import Foundation

final class Profile: Object {
    @objc dynamic var user: String?
    @objc dynamic var email: String?
    @objc dynamic var phone: String?
    @objc dynamic var image: Data?
    @objc dynamic var protectionState = false
    
    override class func primaryKey() -> String? {
        return "email"
    }
}
