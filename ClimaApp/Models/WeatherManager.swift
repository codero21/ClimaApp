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
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    //                    Parse JSON Data - coonvert it into ta Swift Object
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            //4.        Start the Task
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherDate.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
        
    }
    
}
