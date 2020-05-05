//
//  ViewController.swift
//  ClimaApp
//
//  Created by Rollin Francois on 4/30/20.
//  Copyright © 2020 Francois Technology. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        Give ViewController authority on field.
        searchTextField.delegate = self
    }

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

