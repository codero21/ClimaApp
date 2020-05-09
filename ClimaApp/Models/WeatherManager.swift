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
        performRequest(urlString: urlString)
        print(urlString)
    }
    
    func performRequest(urlString: String) {
//1.        Create a URL
        if let url = URL(string: urlString) {
            //2.        Create a URL Session
            let session = URLSession(configuration: .default)
            
            //3.       Give the Session a Task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
                    
            //4.        Start the Task
            task.resume()
        }
        
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
    
}
