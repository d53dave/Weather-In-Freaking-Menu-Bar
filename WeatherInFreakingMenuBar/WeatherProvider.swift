//
//  WeatherProvider.swift
//  WeatherInFreakingMenuBar
//
//  Created by David Sere on 13/07/16.
//  Copyright © 2016 d53dev. All rights reserved.
//

import Foundation

protocol WeatherProvider {
    func getCurrentWeatherForLocation(lat: Double, lon: Double, completion: (LocalWeather?) -> ())
    func getDayforecast(date: NSDate, completion: (LocalWeather?) -> ())
}
