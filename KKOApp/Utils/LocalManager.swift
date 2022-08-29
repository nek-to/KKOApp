//
//  LocalManager.swift
//  KKOApp
//
//  Created by VironIT on 29.08.22.
//

import Foundation

struct LocaleManager {

    /// "ko-US" → "ko"
    static var languageCode: String? {
        guard var splits = Locale.preferredLanguages.first?.split(separator: "-"), let first = splits.first else { return nil }
        guard 1 < splits.count else { return String(first) }
        splits.removeLast()
        return String(splits.joined(separator: "-"))
}

    static var language: Language? {
        return Language(languageCode: languageCode)
    }
}
