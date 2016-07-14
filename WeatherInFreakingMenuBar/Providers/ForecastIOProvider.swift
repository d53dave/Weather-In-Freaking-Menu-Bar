//
//  ForecastIOProvider.swift
//  WeatherInFreakingMenuBar
//
//  Created by David Sere on 13/07/16.
//  Copyright © 2016 d53dev. All rights reserved.
//

import Foundation
import ForecastIO

class ForecastIOProvider: WeatherProvider {
    
    private let client: APIClient
    
    init(apiKey: String){
        self.client = APIClient(apiKey: apiKey)
        client.units = .Auto
    }
    
    func getCurrentWeatherForLocation(lat: Double, lon: Double, completion: (LocalWeather?) -> ()){
        client.getForecast(latitude: lat, longitude: lon) { (currentForecast, error) -> Void in
            if let currentForecast = currentForecast {
                let currently = currentForecast.currently
                let result = LocalWeather(date: NSDate(), lat: lat, lon: lon, condition: .ClearDay, temperature: Double((currently?.temperature)!), precipitation: Double((currently?.precipIntensity)!))
                completion(result)
            } else if let error = error {
                log.error(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getDayforecast(date: NSDate, completion: (LocalWeather?) -> ()){
        completion(nil)
    }
    
}
