//
//  LocalWeather.swift
//  WeatherInFreakingMenuBar
//
//  Created by David Sere on 13/07/16.
//  Copyright © 2016 d53dev. All rights reserved.
//

import Foundation

enum WeatherCondition{
    case ClearDay, ClearNight, Rain, Snow, Sleet, Wind, Fog, Cloudy, PartlyCloudyDay, PartlyCloudyNight
}

struct LocalWeather {
    let date: NSDate
    let lat: Double
    let lon: Double
    let condition: WeatherCondition
    let temperature: Double
    let precipitation: Double
}
