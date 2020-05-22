//
//  WeatherDate.swift
//  ClimaApp
//
//  Created by Rollin Francois on 5/12/20.
//  Copyright © 2020 Francois Technology. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
}
 
struct Weather: Codable {
    let id: Int
}
