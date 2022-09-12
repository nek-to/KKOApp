//
//  WeatherWidgetView.swift
//  KKOApp
//
//  Created by VironIT on 12.09.22.
//

import SwiftUI
import WidgetKit

struct WeatherWidgetView: View {
    var entry: WeatherEntry
    var fon = Image(uiImage: UIImage(named: "weather")!)
    
    var body: some View {
        ZStack {
            fon.resizable()
                .aspectRatio(contentMode: .fill)
            HStack {
                VStack(alignment: .center) {
                    Text("Minsk")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 5.0)
                        .frame(width: 100.0, height: 25.0)
                    Text("\(entry.weather.temp!)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.top, 5.0)
<<<<<<< HEAD
                        .frame(height: 35.0)
=======
                        .frame(width: 100, height: 35.0)
>>>>>>> final
                    Image(uiImage: UIImage(named: entry.weather.icon!)! )
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
                .padding(25)
                .background(.black)
                .frame(width: 140, height: 140)
                .cornerRadius(20)
                Spacer()
                VStack(alignment: .center) {
                    ZStack {
                        Image(uiImage: UIImage(named: entry.weather.coffeeImage!) ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 140)
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 140, height: 70, alignment: .center)
                            .opacity(0.7)
                        ZStack {
                            Text(entry.weather.coffeeName!)
                                .font(.body)
                                .foregroundColor(.white)
<<<<<<< HEAD
                                .lineLimit(3)
                                .frame(width: 100, height: 40, alignment: .center)
=======
                                .multilineTextAlignment(.center)
                                .lineLimit(3)
                                .frame(width: 100, height: 70, alignment: .center)
>>>>>>> final
                        }
                        .padding(.bottom, 30.0)
                    }
                }
                .padding(20)
                .frame(width: 140, height: 140)
                .cornerRadius(20)
            }.padding(15)
        }
    }
}

struct WeatherWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherWidgetView(entry: WeatherEntry(date: Date(), weather: WidgetWeather(temp: "10", icon: "error", coffeeName: "Espresso", coffeeImage: "coffee1")))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
