//
//  WeatherModel.swift
//  Weather App
//
//  Created by Walid  on 7/8/20.
//  Copyright © 2020 Walid . All rights reserved.
//

import Foundation
struct WeatherModel {
    
    let name: String
    let temp: Double
    let weatherid: Int
    
    var tempartureString: String {
        return String(format: "%.1f", temp)
    }
    
    var conditionName: String {
        switch weatherid {
         case 200...232:
                   return "cloud.bolt"
               case 300...321:
                   return "cloud.drizzle"
               case 500...531:
                   return "cloud.rain"
               case 600...622:
                   return "cloud.snow"
               case 701...781:
                   return "cloud.fog"
               case 800:
                   return "sun.max"
               case 801...804:
                   return "cloud.bolt"
               default:
                   return "cloud"
        }
    }
    
}
