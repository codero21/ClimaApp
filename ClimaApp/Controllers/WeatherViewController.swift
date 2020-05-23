//
//  ViewController.swift
//  ClimaApp
//
//  Created by Rollin Francois on 4/30/20.
//  Copyright © 2020 Francois Technology. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        This Class is the delegate for this property
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
//        This Class is the delegate for this property
        weatherManager.delegate = self
        
//        Give ViewController authority on field.
        searchTextField.delegate = self
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}



//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
        @IBAction func searchPressed(_ sender: UIButton) {
            print(searchTextField.text!)
            
    //        Dismiss keyboard
            searchTextField.endEditing(true)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            print(searchTextField.text!)
            
            //        Dismiss keyboard
            searchTextField.endEditing(true)
            return true
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != "" {
                return true
            } else {
                textField.placeholder = "Enter a City Name"
                return false
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
    //        Use searchTextField.text to get the weather for that city.
            if let city = searchTextField.text {
                weatherManager.fetchWeather(cityName: city)
            }
    //        Clear user input.
            searchTextField.text = ""
    //        Reset placeholder text after user attmpts blank entry.
            textField.placeholder = "Search"
        }
}

//MARK: - WeatherManagerDelegate


extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print(weather.temperature)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: - CLLocationManagerDelegate


extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got location Data")
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latituade: lat, longitude: lon)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
