//
//  WeatherManager.swift
//  ClimaApp
//
//  Created by Rollin Francois on 5/5/20.
//  Copyright © 2020 Francois Technology. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=imperial&appid=12a5c73edde545ac4fad9cbb73521d20"
    
    var delegate: WeatherManagerDelegate?
    
    
    
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
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            //4.        Start the Task
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temp)
            
//            print("Code is: ", id)
//            print(weather.conditionName)
            print(weather.temperatureString)
            
            return weather
        } catch {
            print(error)
            return nil
        }
        
    }
    
}
