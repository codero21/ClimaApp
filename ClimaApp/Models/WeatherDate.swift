//
//  WeatherDate.swift
//  ClimaApp
//
//  Created by Rollin Francois on 5/12/20.
//  Copyright © 2020 Francois Technology. All rights reserved.
//

import Foundation

struct WeatherDate: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String    
}
