//
//  WeatherProvider.swift
//  KKOApp
//
//  Created by VironIT on 11.09.22.
//
import RealmSwift
import WidgetKit
import SwiftUI

struct WeatherProvider: TimelineProvider {
    typealias Entry = WeatherEntry
    private let storage = try! Realm()
    
    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> Void) {
        let entry = WeatherEntry(date: Date(), weather: WidgetWeather(temp: "0", icon: "error", coffeeName: "empty", coffeeImage: "empty"))
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> Void) {
        let currentDate = Date()
        let refrashDate = Calendar.current.date(byAdding: .minute, value: 10, to: currentDate)!
        loadCoffees()
        
        WeatherNetworkManager.getWeather { (result) in
            var weather = WidgetWeather()
            if let result = result {
                let temp = String(result.data.first?.temp ?? 0)
                weather.temp = "\(temp)°C"
                weather.icon = result.data.first?.weather.icon ?? "error"
            }
            let extractCoffees = storage.objects(Coffee.self)
            let coffees: [Coffee] = extractCoffees.map { $0 }
            let coffee = getRandomCoffee(coffees)
            weather.coffeeName = coffee.name
            weather.coffeeImage = coffee.imageName
            let entry = WeatherEntry(date: Date(), weather: weather)
            let timeline = Timeline(entries: [entry], policy: .after(refrashDate))
            completion(timeline )
        }
    }
    
    func placeholder(in context: Context) -> WeatherEntry {
        return WeatherEntry(date: Date(), weather: WidgetWeather(temp: "0", icon: "error", coffeeName: "empty", coffeeImage: "empty"))
    }
    
    private func getRandomCoffee(_ coffees: [Coffee]) -> Coffee {
        let random = Int.random(in: 0..<coffees.count)
        var coffee: Coffee!
        for index in 0..<coffees.count where coffees[index].name == coffees[random].name {
            coffee = coffees[index]
        }
        return coffee
    }
    
    private func loadCoffees() {
        let counter = storage.objects(Coffee.self).count
        if let path = Bundle.main.path(forResource: "Coffee", ofType: "plist") {
            let arrayRoot = NSArray(contentsOfFile: path)

            if arrayRoot?.count != counter {
                LoaderManager().loadCoffeeInStorage()
            }
        }
    }
}
