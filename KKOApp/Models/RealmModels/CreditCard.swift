//
//  CreditCard.swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//

import Foundation
import RealmSwift

final class CreditCard: Object {
    @objc dynamic var number: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var cvc: Int = 0
    @objc dynamic var fonImage: String = ""
}
