//
//  Network .swift
//  KKOApp
//
//  Created by VironIT on 26.08.22.
//
import UIKit

final class UnsplashNetworkManager {
    static func getImageFromStock(complition: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://api.unsplash.com/photos/random/?client_id=poKYChAaQN0zIOEjTDBlkSrbNLrdOaimHBZtboiyGaY") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let resData = try? JSONDecoder().decode(UnsplashResponse.self, from: data)
            if let resData = resData {
                DispatchQueue.main.async {
                complition(resData.urls.small)
                }
            }
        }
        .resume()
    }
}

struct UnsplashResponse: Codable {
    var urls: URLS
}

struct URLS: Codable {
    var small: String
}

