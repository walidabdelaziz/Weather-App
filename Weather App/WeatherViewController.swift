//
//  ViewController.swift
//  Weather App
//
//  Created by Walid  on 7/8/20.
//  Copyright © 2020 Walid . All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    
    var weathermanager = WeatherManager()
    var locationmanager = CLLocationManager()
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.requestLocation()
        
        
        searchTextField.delegate = self
        weathermanager.delegate = self
        
        // Do any additional setup after loading the view.
    }

   
    
   
}

// Mark: -CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    
    @IBAction func getCurrentLocationButtonPressed(_ sender: UIButton) {
           locationmanager.requestLocation()
       }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationmanager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weathermanager.fetchData(latitude: lat, longitude: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        
        searchTextField.endEditing(true)

        
        
      
}
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = searchTextField.text {
            weathermanager.fetchData(cityName: cityName)
        }
            
        
        searchTextField.text = ""
    }
}


//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weathermanager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = weather.name
            self.tempLabel.text = weather.tempartureString
            self.tempImage.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

