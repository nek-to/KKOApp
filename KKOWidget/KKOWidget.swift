//
//  KKOWidget.swift
//  KKOApp
//
//  Created by VironIT on 11.09.22.
//

import WidgetKit
import SwiftUI

@main
struct KKOWidget: Widget {
    private var kind = "CoffeeSuggester"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: WeatherProvider()) { entry in
            WeatherWidgetView(entry: entry) }
                            .configurationDisplayName("CoffeeSuggester")
                            .description("Advises coffee according to the weather")
                            .supportedFamilies([.systemMedium])
    }
}
