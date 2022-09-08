//
//  WeatherNetworkManager.swift
//  KKOApp
//
//  Created by VironIT on 6.09.22.
//

import UIKit
import CoreLocation

final class WeatherNetworkManager {
    static func getWeather(complition: @escaping (WeatherResponse?) -> Void) {
        let locanionManager = CLLocationManager()
        let latitude = locanionManager.location?.coordinate.latitude
        let longitude = locanionManager.location?.coordinate.longitude
        guard let url = URL(string: "https://api.weatherbit.io/v2.0/current?lat=\(latitude ?? 53.916902)&lon=\(longitude ?? 27.583229)&key=f0c5447dde504c928db84296d5aae097") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            let resData = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            if let resData = resData {
                DispatchQueue.main.async {
                    complition(resData)
                }
            }
        }
        .resume()
    }
}

struct WeatherResponse: Codable {
    var data: [Datum]
}

struct Datum: Codable {
    var temp: Double
    var weather: Weather
}

struct Weather: Codable {
    var icon: String
}
