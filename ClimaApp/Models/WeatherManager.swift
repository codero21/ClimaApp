//
//  WeatherManager.swift
//  ClimaApp
//
//  Created by Rollin Francois on 5/5/20.
//  Copyright © 2020 Francois Technology. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=imperial&appid=12a5c73edde545ac4fad9cbb73521d20"
    
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
    
}
