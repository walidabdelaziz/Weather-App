//
//  WeatherManager.swift
//  Weather App
//
//  Created by Walid  on 7/8/20.
//  Copyright © 2020 Walid . All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weathermanager:WeatherManager ,weather: WeatherModel)
    func didFailWithError(error: Error)
    

}

struct WeatherManager {
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=bca6b6f93b9b3306a8b8df6ba3c4a44d&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchData(cityName: String){
        let fullWeatherUrl = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: fullWeatherUrl)
    }
    func fetchData(latitude:CLLocationDegrees,longitude:CLLocationDegrees){
        let fullWeatherUrl = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: fullWeatherUrl)
    }
    
    func performRequest(with urlString: String){
        // 1-create url
        if let url = URL(string: urlString) {
            
            // 2- create session url
            let session = URLSession(configuration: .default)
            
            // 3- make session do a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let weather = self.parseData(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)                    }
                }
            }
            // 4- start task
            task.resume()
        }
    }
    
    
    func parseData(_ weatherData: Data) -> WeatherModel?{
        
        let decoder = JSONDecoder()
        do {
        let decodeddata = try decoder.decode(WeatherData.self, from: weatherData)
        
            let cityname = decodeddata.name
            let temp = decodeddata.main.temp
            let id = decodeddata.weather[0].id
            
            let weather = WeatherModel(name: cityname, temp: temp, weatherid: id)
            return weather
        
            
        } catch {
            
            delegate?.didFailWithError(error: error)
            return nil
        
        }
        
    }
    
    
    
}
